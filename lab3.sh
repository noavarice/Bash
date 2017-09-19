#! /bin/bash

MOUNT_POINT_FIELD_INDEX=2
FS_TYPE_FIELD_INDEX=3
fstab_info="cat /etc/fstab | grep -iP '^[/]?\w+' | tr -s ' '"
fs_types_and_count=($(eval $fstab_info | cut -d ' ' -f${FS_TYPE_FIELD_INDEX} | sort -ir | uniq -c))
fs_distinct_types_count=$((${#fs_types_and_count[*]} / 2))
fs_type_to_mount_point=($(eval $fstab_info | cut -d ' ' -f${MOUNT_POINT_FIELD_INDEX},${FS_TYPE_FIELD_INDEX}))
pairs_count=$((${#fs_type_to_mount_point[*]} / 2))
# для каждого типа ФС выводим, собственно, тип и количество устройств с таким типом
for ((i = 0; i < fs_distinct_types_count; i++))
do
    fs_type=${fs_types_and_count[((i * 2 + 1))]}
    count=${fs_types_and_count[((i * 2))]}
    printf "Type: %s, %d mount point(s)" $fs_type $count
    # для устройств с типом ФС ext* выводим еще и точки монтирования
    declare -a mount_points
    if [[ $fs_type =~ ^(ext|reiser) ]]; then
        for ((j = 0; j < pairs_count; j++))
        do
            if [[ $fs_type == ${fs_type_to_mount_point[((j * 2) + 1)]} ]]; then
                mount_points+=(${fs_type_to_mount_point[((j * 2))]})
            fi
        done
        echo " ($(sed s/..$// <<< $(printf "\"%s\", " ${mount_points[@]})))"
    else
        echo
    fi
done
