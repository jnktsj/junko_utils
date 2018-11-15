#!/bin/bash
grep -v "#" $1 | head -n1 | tr "\t" "\n" | awk '{print NR"\t"$0}'
