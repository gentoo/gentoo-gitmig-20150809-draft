# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-vi-en/vdict-vi-en-20050224.ebuild,v 1.2 2005/08/23 22:28:08 pclouds Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Vdict - Dictionaries files"
SRC_URI="mirror://sourceforge/xvnkb/vi-en.src.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="app-dicts/vdict"
S=${WORKDIR}
src_compile() {
	wd2vd -s vi-en.src -d vi-en.vdbf -i vi-en.vdbi -x "Vietnamese-English"
}

src_install() {
	insinto /usr/share/dict
	doins vi-en.vdbf vi-en.vdbi
}
pkg_postinst() {
	einfo "Please do search for dictionaries in vdict"
}
