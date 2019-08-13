#!/bin/bash

total_lines=0

for file in $(find -follow | grep .java); do
    lines=$(wc -l $file | grep -o -E "^[0-9]+")
    total_lines=$((total_lines+lines))
done

echo $total_lines
