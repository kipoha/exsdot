#!/bin/bash

# Возвращает среднее значение одного "бара" CAVA
tail -n 1 ~/.config/cava/output.txt | awk -F';' '{sum=0; for(i=1;i<=NF;i++) sum+=$i; print int(sum/NF)}'
