#!/bin/sh

GORUA_DATADIR=%%GORUA_DATADIR%%
#BBSMENU=http://www43.tok2.com/home/syatol/2chboard/2chmenu.html
BBSMENU=http://azlucky.s25.xrea.com/2chboard/bbsmenu.html

cd ${GORUA_DATADIR}
make BOARDINFO_URL=${BBSMENU} update > /dev/null 2>&1
cd -

exec /usr/bin/goRua.rb
