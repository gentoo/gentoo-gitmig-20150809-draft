# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles-extra/commonbox-styles-extra-0.1.ebuild,v 1.6 2002/12/15 10:44:24 bjb Exp $

DESCRIPTION="Extra styles pack for {flux,black,open}box"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://mkeadle.org/ebuilds/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="media-gfx/xv
	virtual/x11"

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*
	insinto /usr/share/commonbox/backgrounds
	doins ${S}/backgrounds/*
	dodoc README.commonbox-styles-extra COPYING
}
