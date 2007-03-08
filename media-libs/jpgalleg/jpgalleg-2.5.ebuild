# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpgalleg/jpgalleg-2.5.ebuild,v 1.1 2007/03/08 19:33:49 anant Exp $

inherit eutils

DESCRIPTION="The jpeg loading routines are able to load almost any JPG image
file with Allegro."
HOMEPAGE="http://www.ecplusplus.com/index.php?page=projects&pid=1"
SRC_URI="http://www.ecplusplus.com/files/${PN}-${PV}.tar.gz"

LICENSE="ZLIB"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.0"
S="${WORKDIR}/${PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./fix.sh unix --quick
	emake || die "emake failed"
}

src_install() {
	mkdir ${D}usr
	mkdir ${D}usr/include
	mkdir ${D}usr/lib

	emake install INSTALL_BASE_PATH="${D}usr" || die "emake install failed"

	dodoc readme.txt

	insinto /usr/share/doc/${P}/examples
	doins examples/*
}
