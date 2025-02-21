# Configuration of VS Code remote SSH extension for running inside container

In order to properly connect with the container using SSH remote dev plugin, the following configuration is required:
```json
"remote.SSH.enableRemoteCommand": true,
"remote.SSH.useLocalServer": true,
"remote.SSH.configFile": "<SSH CONFIG PATH>",
```

If you are running with `apptainer` then nothing additional is required; however, if you are using `singularity` then additional configuration for the server install path will be required. A simple search should return results.

Finally, for some reason, with at least the bell cluster, "reviving" terminal sessions sort of breaks everything randomly requiring a vscode-server restart (not fun). So for the time being, ensure the following is in the settings to prevent reviving terminals:
```json
"terminal.integrated.persistentSessionReviveProcess": "never",
```

## Mac OSx configuration
If you will only ever connect via one host OS (i.e. only windows or only mac), the above is likely to be sufficient. I do not know how differing versions of host OS though impacts connecting using Remote SSH. 

For times when multiple OSs will be needed however, it will be necesary to set some additional parameters as below:
```json
"remote.SSH.serverInstallPath": {
        "<Host name from SSH config>": "<path to install remote server on the host system>"
    },
"remote.SSH.useLocalServer": false,
```

It is not quite exactly clear when `remote.SSH.useLocalServer` is required to be set, but if you add this, ensure that the same line doesn't appear above as well.

# Configuration of SSHconfig File
The file `apptainerSSHConfig` contained in this folder outlines the configuration and its contents should be placed inside the same file for used for the `remote.SSH.configFile` used above. It is necessary to include the `-s /bin/bash` in order to include a reload of the `~/.bashrc` file containing all requisite paths for usage with mamba. However, after several long hours, the `PS1` variable is still being written in a weird fashion, so the only way to get the fun prompt back is to resource it again after the terminal has started. Even exporting the `APPTAINERENV_PS1` variable doesn't keep dynamic functionality of the `PS1` variable, rather it is static until resourcing is done. :(

Specifically for identity keys, at least on Purdue's bell cluster, it seems that keys are bound automatically. Nevertheless, that means the host `ssh_config` file should include proper configuration for `github.com` host as included in the `apptainerSSHConfig` file. Alternatively, and for other non-github connections, if you need a key to be indiscriminately added to the `ssh-agent` the `Host *` will essentially add all identity keys for any connection. This is not the best practice, but should work in a pinch. 

Execution of `ssh -T git@github.com` from inside the apptainer should result in affirmative authentication if setup is finished properly.

# Configuration of `.bashrc`
Note to self: it may be best in the future, to make the bashrc more apptainer to reduce latency. If it is connecting to an apptainer via SSH then we don't need any prompt configuration as we will need to resource to set `PS1`. Realistically, we only need the mamba/conda environments set, and then we can handle the "pretty print" of the prompt when we re-source once inside the shell.if needed (as is the case for an interactive terminal).

This is possible by using the following:
```bash
    if [ -n "$APPTAINER_CONTAINER" ]; then
        # EXECUTE CONTAINER SPECIFIC CODE HERE. ":" provided below in case it's empty to avoid syntax errors
        :
    else
        # Execute general code here, but be careful as this will not run from the ssh config provided here
        eval `ssh-agent -s`
    fi
```

# Manually binding ssh agents to Apptainer

In the event that the host apptainer configuration does not automatically bind ssh keys, it may be necessary to manually bind the agent. In that case, the following command `-B $SSH_AUTH_SOCK` should be passed in when starting the apptainer or added to the SSH `RemoteCommand` line. This binds the host authentication socket to the Apptainer and pipes it appropriately. Now, in order for `$SSH_AUTH_SOCK` to hold a value `sshd` must be "running" in the session. In such cases, it is easiest to include the `eval...` line from above in the source `rc` file on startup of the desired shell. 

