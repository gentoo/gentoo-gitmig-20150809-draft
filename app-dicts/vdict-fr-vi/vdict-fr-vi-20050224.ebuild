# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-fr-vi/vdict-fr-vi-20050224.ebuild,v 1.2 2005/08/23 22:27:50 pclouds Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Vdict - Dictionaries files"
SRC_URI="mirror://sourceforge/xvnkb/fr-vi.src.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="app-dicts/vdict"
S=${WORKDIR}
src_compile() {
	wd2vd -s fr-vi.src -d fr-vi.vdbf -i fr-vi.vdbi -x "French-Vietnamese"
}

src_install() {
	insinto /usr/share/dict
	doins fr-vi.vdbf fr-vi.vdbi
}
pkg_postinst() {
	einfo "Please do search for dictionaries in vdict"
}
