separator_char='\ue0b1'
reset_color='%{%f%k%}'

print-last-code() {
    [[ (-n "$last_code") && ($last_code -ne 0) ]] && echo -n " %F{red}$last_code$reset_color $separator_char"
}

print-user() {
    echo -n " %F{240}%n $reset_color$separator_char"
}

print-git-status() {
    local branch=$(git symbolic-ref --short HEAD 2> /dev/null)

    if [[ -n "$branch" ]]; then
        git diff --quiet --ignore-submodules --exit-code HEAD > /dev/null 2>&1

        if [[ "$?" != 0 ]]; then
            text_color=red
        else
            text_color=blue
        fi

        echo -n "%F{$text_color} $branch $reset_color$separator_char"
    fi
}

print-dir() {
    echo -n " %~ $separator_char"
}

prompt() {
    print-last-code
    print-user
    print-git-status
    print-dir
    echo -n " "
}

precmd() {
    last_code=$?
}

[[ ${precmd_functions[(r)precmd]} != "precmd" ]] && precmd_functions+=(precmd)

PROMPT="$(prompt)"
