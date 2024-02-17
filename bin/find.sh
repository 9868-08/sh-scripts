#/bin/sh

################################################################################
# Change History                                                               #
# 20/1/2021  Roman Ermolaev Original code. This is a template for creating     #
################################################################################

grep -rnw $1 -e $2
#sudo find $1 -type f |xargs grep $2
