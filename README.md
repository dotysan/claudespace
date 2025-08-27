# claudespace

## Bootstrap claude-flow into a GitHub Codespace

First create a GitHub repo from this template repo. Then in your new repo, create a new Codespace with options. Make sure to bump up to at least 8 CPUs ore more.

### Then in the Codespace terminal

1. **Run the boostrap script**

   - `./hello-claude.sh`

It will check dependencies, install a Python virtual environment, and bootstrap some scaffolding.

Then it will prompt you for an Anthropic account. Since you are running in a remote codespace, your local browser can't talk to it. So skip the first URL prompt for remote Anthropic authentiation.

Then a second, URL prompt will appear. Copy/paste the second one into a browser. This will allow you to locally authenticate. Then copy/paste the auth code back into here.

Once Claude Code is running, type `/exit` to complete the script setup. Then relaunch the terminal to complete integrating Claude with VSCode.

1. **Start Claude Code again**

   - `./hello-claude.sh`

Leave this first terminal running Claude Code.

1. **Open a second terminal window**

   - ``Ctrl+Shift+` ``

1. **Initialize Claude-Flow**

   - `uv run claude-flow init --verify`

1. **OPTIONAL - Commit the Claude-Flow init stuff**

   - `git add .`
   - `git commit -m 'claude-flow init --verify'`

1. **And install the GitHub hooks for checkpointing**

   - `uv run claude-flow github init`

1. **Run Claude Flow with a prompt**

   - example: `uv run claude-flow swarm --output-format text --strategy development "Deploy a quantum banana peeler that runs in Docker, speaks fluent YAML, and auto-generates limericks about GitHub merge conflicts."`
