#! /bin/sh -x

factorial() {
    seq -s "*" 1 $1 | bc
}

param_count="$#"
num_regex='^[0-9]+$'
if [[ param_count -eq 1 ]]; then
    if [ "$1" == "-h" ]; then
        printf "%s\n%s\n" "factorial <number> [-h]" "Counts factorial of given <number>"
    elif ! [[ "$1" =~ $num_regex ]]; then
        echo "\"$1\": is not a number"
        exit 1
    else
        factorial $1
    fi
else
    echo "Illegal parameters count"
    printf "%s\n%s\n" "factorial <number> [-h]" "Counts factorial of given <number>"
fi
