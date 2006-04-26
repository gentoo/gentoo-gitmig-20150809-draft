# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.0.11.ebuild,v 1.7 2006/04/26 22:26:10 halcy0n Exp $

inherit kde

# version does not change with every release
DOC="krename-3.0.3.pdf"

DESCRIPTION="KRename - a very powerful batch file renamer"
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2
	doc? ( mirror://sourceforge/krename/${DOC} )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc"

need-kde 3.1

src_install() {
	kde_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/${DOC}
	fi
}
