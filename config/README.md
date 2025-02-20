# Shell scripts

## `personalConfig.sh`
This script contains a bunch of start-up aliases generally for getting github authentication set up on new shells. 

### Setup
Clone this repo, navigate to the config folder, and run `source personalConfig.sh`

### Functions 

#### gengitssh
This function is a little "function-like" alias that is used to quickly generate an SSH key (without a passphrase) and return it to the command line, so all you have to do is copy the SSH public key line and upload it to github.

To use, simply run `gengitssh <YOUR EMAIL HERE> <FILE PATH>` with your email entered (it is advised that it is the "private" github email) and the file path (which can be either absolute or relative, although I prefer absolute).

Unfortunately, this function does not check for any errors (so not very robust) and also requires manual copying (since `clip` and `xclip` may require installation on systems). 

#### initgitrepo
This function is another little "function-like" alias that initializes the username and email for a git repo. To use, simply run `gengitssh <YOUR NAME> <YOUR EMAIL HERE>` with your name and email (preferred "private" github email) substituted.

Note, if you have just cloned a repo, and did not set this, you will be met with a sync error due to "publishing a private email...". To correct, you will need to configure your name and email as above, run `git commit --amend --reset-author --no-edit` and then re-sync the commit with the remote repo.