# Some Bash Goodies

## Commented-out code detection in Git commits

For instance, add a commented-out code detection filter to your favourite CI system:

```
wget https://raw.githubusercontent.com/jsrois/bash_goodies/master/commented_out_code.sh
# Jenkins conveniently defines the $GIT_PREVIOUS_COMMIT, so we can
# analyze all the commits following that one
bash commented_out_code.sh  $GIT_PREVIOUS_COMMIT
```
