# Configuration of VS Code remote SSH extension

In order to properly connect with the SSH server, the following configuration is required:
```
"remote.SSH.enableRemoteCommand": true,
"remote.SSH.useLocalServer": true,
"remote.SSH.configFile": "<SSH CONFIG PATH>",
```

If you are running with `apptainer` then nothing additional is required; however, if you are using `singularity` then additional configuration for the server install path will be required. A simple search should return results.

Finally, for some reason, with at least the bell cluster, "reviving" terminal sessions sort of breaks everything randomly requiring a vscode-server restart (not fun). So for the time being, ensure the following is in the settings to prevent reviving terminals:
```
"terminal.integrated.persistentSessionReviveProcess": "never",
```

# Configuration of SSH File
The file `apptainerSSHConfig` contained in this file outlines the configuration and should be placed inside the same file for used for teh `remote.SSH.configFile` used above. It is necessary to include the `-s /bin/bash` in order to include a reload of the `~/.bashrc` file containing all requisite paths for usage with mamba. However, after several long hours, the `PS1` variable is still being written in a weird fashion, so the only way to get the fun prompt back is to resource it again after the terminal has started. Even exporting the `APPTAINERENV_PS1` variable doesn't keep dynamic functionality of the `PS1` variable, rather it is static until resourcing is done. :(
