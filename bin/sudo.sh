#/bin/sh
################################################################################
# Copyright (C) 2022 Roman Ermolaev                                            #
################################################################################

echo "dinky ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-dinky-for-sudo-password
