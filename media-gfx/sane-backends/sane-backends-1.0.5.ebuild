# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.5.ebuild,v 1.1 2001/10/09 17:06:28 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy - Backends"
SRC_URI="ftp://ftp.mostang.com/pub/sane/sane-$PV/$P.tar.gz"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b"

src_unpack() {
    unpack ${A}
    cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei
}

src_compile() {
    cd ${S}
    ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --host=${CHOST} || die
    make || die
}

src_install () {
    cd ${S}
    make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
    dodoc AUTHORS COPYING ChangeLog LEVEL2 LICENSE NEWS
    dodoc PROBLEMS PROJECTS README* TODO
    docinto backend
    cd backend
    dodoc GUIDE *.README *.BUGS *.CHANGES *.FAQ *.TODO
}

