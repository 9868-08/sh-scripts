#!/bin/bash -x

################################################################################
# 07/02/2024  Roman Ermolaev Original code.                                    #
################################################################################

bleachbit --list | grep -E "[a-z0-9_\-]+\.[a-z0-9_\-]+" | grep -v system.free_disk_space | xargs bleachbit --clean

