# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles/commonbox-styles-0.5.ebuild,v 1.6 2003/06/20 14:24:01 mkeadle Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Common styles for fluxbox, blackbox, and openbox."
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://mkeadle.org/distfiles/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND="virtual/x11"

src_install () {

	insinto /usr/share/commonbox/backgrounds
	doins ${S}/backgrounds/*

	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*

	dodoc README.commonbox-styles COPYING STYLES.authors

}
