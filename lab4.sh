#! /bin/bash

gawk -f lab4.awk /etc/fstab | pdflatex
