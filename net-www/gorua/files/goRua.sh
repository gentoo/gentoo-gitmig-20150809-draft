#!/bin/sh

GORUA_DATADIR=%%GORUA_DATADIR%%

cd ${GORUA_DATADIR} ; make update > /dev/null 2>&1
cd -

exec goRua.rb
