# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-en-vi/vdict-en-vi-20050224.ebuild,v 1.4 2007/01/25 04:55:49 genone Exp $

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
	elog "Please do search for dictionaries in vdict"
}
