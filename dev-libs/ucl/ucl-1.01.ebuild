# Copyright 1998-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.01.ebuild,v 1.3 2002/08/01 18:46:28 seemant Exp $

DESCRIPTION="UCL: The UCL Compression Library"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/ucl-1.01.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	mkdir -p ${D}usr/src/
	cp -r ${S} ${D}usr/src/
}
