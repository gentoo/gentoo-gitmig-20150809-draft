# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ollie Rutherfurd <oliver@rutherfurd.net>
# $header$

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit."
SRC_URI="http://www.river-bank.demon.co.uk/software/"${A}
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND="virtual/python
        >=x11-libs/qt-x11-1.4.2
        dev-python/sip-2.4"

src_compile() {
    cd ${S}
    try ./configure --prefix=${D}/usr
    try make
}

src_install() {
    cd ${S}
    make install
    dodoc COPYING NEWS README THANKS
    docinto doc/
    dodoc doc/*
    docinto examples
    dodoc examples/*
}
 