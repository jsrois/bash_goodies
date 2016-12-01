#!/bin/bash
total_lines=0
readonly threshold=2
if [ "$#" -ge 1 ]; then 
 first_commit=$1
else
 first_commit=HEAD^
 echo "Analyzing last commit only"
fi

for commit in $(git log $first_commit..HEAD --pretty=format:"%h") ; do
 echo "Analyzing commit $commit ..."
 for file in $(git diff-tree --no-commit-id --name-only -r $commit) ; do
  commented_out_lines=$(git show $commit --no-ext-diff --unified=0 --exit-code -a --no-prefix -- $file | egrep "^\+//")
  commented_out_lines_count=$(echo "$commented_out_lines" | wc -l | awk '{print $1}')
  if [ "$commented_out_lines_count" -gt 1 ]; then
   total_lines=$(($total_lines+$commented_out_lines_count))
   echo "Found the following $commented_out_lines_count commented-out lines in file $file:"
   echo "$commented_out_lines"
  fi
 done
done

echo "Summary:"
echo "Found a total of $total_lines commented-out lines of code."
 
if [ "$total_lines" -ge $threshold ]; then
 return 1
fi
