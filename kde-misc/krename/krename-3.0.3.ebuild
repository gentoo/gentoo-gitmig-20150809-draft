# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.0.3.ebuild,v 1.5 2005/04/05 20:36:05 cryos Exp $

inherit kde

#needed for rc versions
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

# version does not change with every release
DOC="krename-3.0.3.pdf"

DESCRIPTION="KRename - a very powerful batch file renamer"
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/krename/${DOC})"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc ~sparc"
IUSE="doc"

need-kde 3.1

src_install() {
	kde_src_install
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/${DOC}
	fi
}