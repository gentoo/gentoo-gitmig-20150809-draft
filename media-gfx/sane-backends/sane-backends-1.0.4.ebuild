# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.4.ebuild,v 1.1 2001/02/02 19:49:09 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy - Backends"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}.tar.gz"
HOMEPAGE="http://www.mostang.com/sane/"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei
}

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b"

RDEPEND="$DEPEND
	 virtual/bash"

	 
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --sysconfdir=/etc --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr sysconfdir=${D}/etc install

    dodoc AUTHORS COPYING ChangeLog LEVEL2 LICENSE NEWS
    dodoc PROBLEMS PROJECTS README* TODO
    docinto backend
    cd backend
    dodoc GUIDE *.README *.BUGS *.CHANGES *.FAQ *.TODO
}

