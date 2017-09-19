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
    for (item in arr) {
        printf "%s:", item;
        split(arr[item], dirs, " ");
        if (length(dirs) == 0) {
            printf "\n";
            continue;
        }
        for (i in dirs) {
            printf "\t%s\n", dirs[i];
        }
    }
}
