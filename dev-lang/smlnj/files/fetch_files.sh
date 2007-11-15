#!/bin/bash

PV=$1
P=smlnj-${PV}
TARGET_DIR=${2:-"/space/distfiles-local"}

BASE_URI="http://smlnj.cs.uchicago.edu/dist/working/${PV}/"

ARCHES="
ppc
sparc
x86
"

FILES="
config.tgz

cm.tgz
compiler.tgz
runtime.tgz
system.tgz
MLRISC.tgz
smlnj-lib.tgz

ckit.tgz
nlffi.tgz

cml.tgz
eXene.tgz

ml-lex.tgz
ml-yacc.tgz
ml-burg.tgz
ml-lpt.tgz

pgraph.tgz
trace-debug-profile.tgz

heap2asm.tgz

smlnj-c.tgz
"

for arch in ${ARCHES}; do
    FILES+="boot.${arch}-unix.tgz "
done

echo ${BASE_URI}
echo ${FILES}

#FILES="heap2asm.tgz"

for file in ${FILES}; do
    wget ${BASE_URI}/${file} -O ${TARGET_DIR}/${P}-${file}
done


