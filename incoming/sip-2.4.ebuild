# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ollie Rutherfurd <oliver@rutherfurd.net>
# $header$

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/software/"${A}
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND="virtual/python"

src_compile(){
    cd ${S}
    try ./configure --prefix=${D}/usr
    try make
}

src_install() {
    cd ${S}
    make install
    dodoc AUTHORS
    dodoc COPYING
    dodoc NEWS
    dodoc README
    dodoc THANKS
    dodoc TODO
}
 