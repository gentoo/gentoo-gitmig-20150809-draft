# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-en-vi/vdict-en-vi-20050224.ebuild,v 1.1 2005/02/24 08:06:49 pclouds Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="Vdict - Dictionaries files"
SRC_URI="mirror://sourceforge/xvnkb/en-vi.src.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="app-dicts/vdict"
S=${WORKDIR}
src_compile() {
	wd2vd -s en-vi.src -d english-viet.vdbf -i english-viet.vdbi -x "English-Viet"
}

src_install() {
	insinto /usr/share/dict
	doins english-viet.vdbf english-viet.vdbi
}
pkg_postinst() {
	einfo "Please do search for dictionaries in vdict"
}
