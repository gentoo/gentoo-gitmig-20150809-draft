# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exiftool/exiftool-6.13.ebuild,v 1.1 2006/04/10 23:32:33 nattfodd Exp $

inherit perl-module

DESCRIPTION="Read and write meta information from EXIF"
HOMEPAGE="http://www.sno.phy.queensu.ca/~phil/exiftool/"
SRC_URI="http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${PV}.tar.gz"

MY_PN="Image-ExifTool"
LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_PN}-${PV}


src_compile() {
	perl Makefile.PL DESTDIR=${D} || die
	make || die
	make test || die
}

src_install() {
	make install || die
	dodoc Changes README html/*
	dobin exiftool
}
