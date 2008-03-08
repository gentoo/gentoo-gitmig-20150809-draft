# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preview/preview-0.8.5-r1.ebuild,v 1.5 2008/03/08 13:38:25 coldwind Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="Simple image viewer."
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/${P/p/P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix broken french lproj
	rmdir French.lproj/Preview.gorm
	ln -s ../English.lproj/Preview.gorm French.lproj
}
