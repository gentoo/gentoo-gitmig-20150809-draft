# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.01.ebuild,v 1.11 2004/03/14 12:26:11 mr_bones_ Exp $

DESCRIPTION="UCL: The UCL Compression Library"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/ucl-1.01.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc hppa amd64"

src_compile() {
	econf
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodir /usr/src/
	cp -r ${S} ${D}usr/src/
}
