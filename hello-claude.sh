#! /usr/bin/env bash
#
# Laundry list/script how to bootstrap claude-flow.
#
set -e
set -u
set -x

UV_INSTALL=https://gist.github.com/dotysan/fdbfc77b924a08ceab7197d010280dac/raw/uv-install.sh
PYTHON_VER=3.13

main() {
    chk_deps
    mk_venv
    install_npm
    install_claude

    uv run claude config list
    uv run claude config set hasTrustDialogAccepted true
    # uv run claude config set hasCompletedProjectOnboarding true
    uv run claude config list

    run_claude

    # uv run claude-flow init
    # uv run claude-flow --help
    # echo 'Ready to swarm!'
}


chk_deps() {

    if ! hash uv  # make sure uv is installed
    then curl -L "$UV_INSTALL" |bash
    fi

    # if ! hash tmux
    # then
    #     echo "ERROR: please install tmux so you can background claude-code."
    #     return 1
    # fi >&2
}

mk_venv() {

    if [[ ! -d .venv  ]]
    then uv venv --managed-python --python="$PYTHON_VER"
    fi

    export DENO_INSTALL="$PWD/.venv"
}

install_npm() {

    if [[ ! -x .venv/bin/nodeenv ]]
    then uv pip install nodeenv
    fi

    if [[ ! -x .venv/bin/npm ]]
    then
        uv run nodeenv --python-virtualenv --node=lts
        echo 'fund=false' >>~/.npmrc
        uv run npm install --global npm
    fi
}

install_claude() {

    if [[ ! -x .venv/bin/claude ]]
    then uv run npm install --global @anthropic-ai/claude-code
    fi

    if [[ ! -x .venv/bin/claude-flow ]]
    then uv run npm install --global claude-flow@alpha
    fi
}

run_claude() {
    if [[ "${CODESPACES:-}" == true && "${TERM_PROGRAM:-}" == vscode ]]
    then

        if [[ ! -e ~/.claude.json ]]
        then
            # trigger the creation of ~/.claude.json
            uv run claude config list --global

            # then bypass some prompts
            jq '.hasCompletedOnboarding        = true
              | .bypassPermissionsModeAccepted = true
              | .hasTrustDialogAccepted        = true
            ' ~/.claude.json |sponge ~/.claude.json

            uv run claude --dangerously-skip-permissions --print /terminal-setup
        fi

        # this will pause here wating for prompts
        if [[ $(jq --raw-output .primaryApiKey ~/.claude.json) == null ]]
        then echo uv run claude --dangerously-skip-permissions --ide /login
        else echo uv run claude --dangerously-skip-permissions --ide
        fi

    else # DANGER! Never --dangerously-skip-permissions on a host
    # then tmux new-session -s claude 'uv run claude --dangerously-skip-permissions'
        uv run claude
    fi
}

main
exit
