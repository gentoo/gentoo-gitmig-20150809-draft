#!/bin/bash

if [ -d $1 ]; then
for i in $1/*; do
/bin/bash $0 $i
done
else
mv $1 tmp
cat tmp | tr -d \\r > $1
rm tmp
fi

