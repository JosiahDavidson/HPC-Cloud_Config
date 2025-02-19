#!/bin/bash
# ===================================================================================
# Script Name: personalConfig.sh
# Description: The script is used for a bunch of personal configurations, usually 
#              only needed to be executed once per deployment. But should they need
#              to be executed multiple times, it may be best to source it inside
#              ~/.bashrc.
# Author: Josiah L. Davidson
# License: MIT No Attribution
# Version: 1.0
# ===================================================================================


# Youg can use these variables for making get config easier. Generally, these wouldn't need to be private
# but just in case, for the commmit they are blank and need to be edited before using.
export GIT_NAME=""
export GIT_EMAIL=""

# Function for generating SSH keys
# USAGE: gengitSSH <email> <path>
# Args:
#   email - string; the email address to sign the generated github key with
#   path - string; the path to store the key. Can be absolute or relative
alias gengitssh='function __gengitssh() { ssh-keygen -t ed25519 -C $1 -f $2 -N "" && echo ">>>>>PUBLIC KEY<<<<<" && cat $2.pub; unset -f __gengitssh; }; __gengitssh'

# Function for setting repo specific username and email
# For my repos, if these aren't set, you can't commit so just to make it easier
# USAGE: initgitrepo <username> <email>
# Args:
#   username - string; the username to sign the generated github key with
#   email - string; the email address to sign the generated github key with
alias initgitrepo='function __initgitrepo() { git config user.name $1 && git config user.email $2; unset -f __initgitrepo; }; __initgitrepo'

