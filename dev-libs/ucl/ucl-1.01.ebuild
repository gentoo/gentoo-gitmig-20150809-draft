# Copyright 1998-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Will Glynn <delta407@lerfjhax.com>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.01.ebuild,v 1.1 2002/06/21 22:07:10 rphillips Exp $

DESCRIPTION="UCL: The UCL Compression Library"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/ucl-1.01.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
LICENSE="GPL"

src_compile() {
	cd ${S}
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	mkdir -p ${D}usr/src/
	cp -r ${S} ${D}usr/src/
}

