# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles-extra/commonbox-styles-extra-0.1.ebuild,v 1.1 2002/10/04 00:43:44 mkeadle Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Extra styles pack for flux|black|open(box)."
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://mkeadle.org/ebuilds/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="media-gfx/xv
		virtual/x11"
RDEPEND=${DEPEND}

src_install () {

	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*
	insinto /usr/share/commonbox/backgrounds
	doins ${S}/backgrounds/*
	dodoc README.commonbox-styles-extra COPYING

}
