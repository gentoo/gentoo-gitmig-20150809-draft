# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/swig/swig-1.3_alpha4.ebuild,v 1.1 2000/09/18 21:07:53 achim Exp $

P=swig1.3a4
A=${P}.tar.gz
S=${WORKDIR}/SWIG1.3a4
DESCRIPTION="Simplified wrapper and interface generator"
SRC_URI="http://download.sourceforge.net/swig/${A}"
HOMEPAGE="http://www.swig.org"


src_compile() {

    cd ${S}
    unset CXXFLAGS
    unset CFLAGS
    try ./configure --prefix=/usr --host=${CHOST} \
	--with-doc=html
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install

}

