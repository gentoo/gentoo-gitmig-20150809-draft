# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/kaffe/kaffe-1.0.6-r1.ebuild,v 1.1 2001/04/28 15:32:24 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/${A}"
HOMEPAGE="http://www.kaffe.org/"

DEPEND=">=dev-libs/gmp-3.1
        >=media-libs/jpeg-6b
        >=media-libs/libpng-1.0.7
	virtual/glibc
	virtual/xfree"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 <${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    cd ${S}
    try ./configure --prefix=/opt/kaffe --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
}
