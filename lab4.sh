#! /bin/bash -x

gawk -f lab4.awk /etc/fstab | pdflatex
