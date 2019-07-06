# Interactive shells
if [ "$PS1" ]; then

    # Append trailing slashes
    cwdSlashAtEnd () {
        TITLE="$(dirs +0)"

        if [ -z "$1" ] ; then
            # no argument, full cwd
            TITLE="${TITLE%/}"
        else
            # one arg, basename only
            TITLE="${TITLE##*/}"
        fi

        echo -n "${TITLE}/"
    }

    # Prompt
    PS1='\[$(printf "\x0f")\033[01;34m\]$(cwdSlashAtEnd)\[\033[00m\]$(__git_ps1 " (%s)") $ '

    # Terminal windows' titles
    case "$TERM" in
    xterm-*|rxvt*|screen*)
        PS1='\[\e]0;\a\033k$(cwdSlashAtEnd base)\033\\\]'"$PS1"
        ;;
    *)
        ;;
    esac

    # Override HOME for cd if ~/workspace exists
    cd()
    {
        if [ -d "$HOME"/workspace ]; then
            HOME=~/workspace command cd "$@"
        else
            command cd "$@"
        fi
    }

    # Aliases
    alias cp="cp -i"
    alias ls="ls -F"
    alias ll="ls -F -l"
    alias mv="mv -i"
    alias rm="rm -i"
    alias sudo="sudo "

    # Which manual sections to search
    export MANSECT=3,2,1
fi
