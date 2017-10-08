{
    if ($0 ~ /^[^#]/) {
        if ($3 ~ /^(ext|reiser)/) {
            arr[$3] = arr[$3]" "$2;
        }
        else
        {
            arr[$3] = "";
        }
    }
}
END {
    printf "\\documentclass{article} ";
    printf "\\begin{document} ";
    printf "\\begin{center} ";
    printf "\\begin{tabular}{ | l | c | } ";
    printf "\\hline ";
    for (item in arr) {
        printf "%s & ", item;
        split(arr[item], dirs, " ");
        if (length(dirs) == 0) {
            printf "- ";
        } else {
            for (i in dirs) {
                printf "%s ", dirs[i];
            }
        }
        
        printf "\\\\ \\hline ";
    }

    printf "\\end{tabular} ";
    printf "\\end{center} ";
    printf "\\end{document} ";
            
}
