# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author James M Long <semaj@semaj.org>

A=${P}.tar.gz
S=${WORKDIR}/Epplets-${PV}
DESCRIPTION="Base Epplets for Enlightment"
SRC_URI="ftp://ftp.enlightenment.org/enlightenment/epplets/${A}"
HOMEPAGE="http://www.enlightenment.org/"

DEPEND=">=x11-wm/enlightenment-0.16"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} 
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
}

