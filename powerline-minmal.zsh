separator_char='\ue0b1'
reset_color='%{%f%k%}'

print-last-code() {
    [[ (-n "$last_code") && ($last_code -ne 0) ]] && echo -n " %F{red}$last_code$reset_color $separator_char"
}

print-user() {
    echo -n " %F{240}%n $reset_color$separator_char"
}

print-dir() {
    echo -n " %~ $separator_char"
}

prompt() {
    print-last-code
    print-user
    print-dir
    echo -n " "
}

precmd() {
    last_code=$?
}

[[ ${precmd_functions[(r)precmd]} != "precmd" ]] && precmd_functions+=(precmd)

PROMPT='$(prompt)'
