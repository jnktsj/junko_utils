#!/bin/bash
head -n1 $1 | tr "\t" "\n" | awk '{print NR"\t"$0}'
