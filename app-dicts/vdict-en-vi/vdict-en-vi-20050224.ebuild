# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-en-vi/vdict-en-vi-20050224.ebuild,v 1.3 2005/08/23 22:27:33 pclouds Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Vdict - Dictionaries files"
SRC_URI="mirror://sourceforge/xvnkb/en-vi.src.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="app-dicts/vdict"
S=${WORKDIR}
src_compile() {
	wd2vd -s en-vi.src -d en-vi.vdbf -i en-vi.vdbi -x "English-Vietnamese"
}

src_install() {
	insinto /usr/share/dict
	doins en-vi.vdbf en-vi.vdbi
}
pkg_postinst() {
	einfo "Please do search for dictionaries in vdict"
}
