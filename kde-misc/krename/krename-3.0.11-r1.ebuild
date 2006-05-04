# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.0.11-r1.ebuild,v 1.1 2006/05/04 17:04:24 carlo Exp $

inherit kde

# version does not change with every release
DOC="krename-3.0.3.pdf"

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2
	doc? ( mirror://sourceforge/krename/${DOC} )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc"

need-kde 3.4

src_install() {
	kde_src_install

	# work around bug #132194
	dodir /usr/share/apps/konqueror/servicemenus/
	mv ${D}/usr/share/services/*.desktop ${D}/usr/share/apps/konqueror/servicemenus/

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/${DOC}
	fi
}
