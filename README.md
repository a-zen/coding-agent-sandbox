# coding-agent-sandbox

A Dockerfile to be used as a sandbox for your coding agent. This is a highly
personal setting and might be chaning on my personal preferences.

## included tools

Comes setup with:

* antigravity-cli
* claude-code
* mise 
* [context-mode](https://github.com/mksglu/context-mode)
* various unix tools needed for day-to-day work

## Usage

I have a shell function to start the docker container with pre-defined mounts:

````bash
agent-sandbox() (
  docker run -ti --rm \
    -v ~/.config/gemini:/home/ubuntu/.gemini \
    -v ~/.config/claude:/home/ubuntu/.claude \
    -v ~/.cache/mise:/home/ubuntu/.cache/mise \
    -v ~/.config/mise:/home/ubuntu/.config/mise \
    -v ~/.local/share/mise:/home/ubuntu/.local/share/mise \
    -v ~/.local/state/mise:/home/ubuntu/.local/state/mise \
    -v ./:/workdir \
    coding-agent-sandbox
)
````

which adds my gemini and claude setup (custom dir), mise caches and the current working
directory.

## mise tasks

<!-- mise-tasks -->
## `build`

- **Usage**: `build`

Builds the docker container

## `docs`

- **Usage**: `docs`
- **Aliases**: `doc`

Update tasks in README

## `run`

- **Usage**: `run`

Runs the docker container for manual testing
<!-- /mise-tasks -->
