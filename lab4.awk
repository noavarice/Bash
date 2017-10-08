{
    if ($0 ~ /^[^#]/) {
        if ($3 ~ /^(ext|reiser)/) {
            arr[$3] = arr[$3]" "$2;
        }
        else
        {
            arr[$3] = " ";
        }

        ++count[$3];
    }
}
END {
    printf "\\documentclass{article}\n";
    printf "\\usepackage[utf8]{inputenc}\n";
    printf "\\usepackage[russian]{babel}\n";
    printf "\\begin{document}\n";
    printf "\\begin{center}\n";
    printf "\\begin{tabular}{ | l | c | c | }\n";
    printf "\\hline \\textbf{Тип файловой системы} & \\textbf{Кол-во вхождений} & \\textbf{Точки монтирования} \\\\ \\hline\n";
    types_count = asorti(arr, sorted_types);
    for (i = types_count; i > 0; --i) {
        item = sorted_types[i];
        printf "%s & ", item;
        printf "%d & ", count[item];
        split(arr[item], dirs, " ");
        if (length(dirs) == 0) {
            printf "- ";
        } else {
            str = "";
            dirs_count = asorti(dirs, sorted_dirs);
            for (j = 1; j <= dirs_count; ++j) {
                dir = sorted_dirs[j];
                str = str dirs[dir] ", ";
            }

            printf "%s", substr(str, 1, length(str) - 2);
        }
        
        printf "\\\\ \\hline\n";
    }

    printf "\\end{tabular}\n";
    printf "\\end{center}\n";
    printf "\\end{document}\n";
            
}
