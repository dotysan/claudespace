# claudespace
Bootstrap claude-flow into a GitHub Codespace.

First create a GitHub Codespace from this repo.

### Then in the Codespace terminal

1. **Run the boostrap script**
 - `./hello-claude.sh`

This will get claude-code running.

2. **Open a new terminal window**
 - `Ctrl-Shift-\`` <!-- ` -->

3. **Initialize Claude Flow**
 - `uv run claude-flow init`

4. **OPTIONAL - Commit the Claude Code init stuff**
 - `git add .`
 - `git commit -m 'claude-flow init'`

4. **Run Claude Flow with a prompt**
 - example: `uv run claude-flow swarm "Deploy a quantum banana peeler that runs in Docker, speaks fluent YAML, and auto-generates limericks about GitHub merge conflicts."`
