# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles-extra/commonbox-styles-extra-0.2-r1.ebuild,v 1.14 2005/08/26 13:36:37 agriffis Exp $

IUSE=""
DESCRIPTION="Extra styles pack for flux|black|open(box)."
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://mkeadle.org/distfiles/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ~ppc-macos ~ppc64 sparc x86"

DEPEND="media-gfx/xv
		virtual/x11"

src_install () {

	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*

	insinto /usr/share/commonbox/backgrounds
	doins ${S}/backgrounds/*

	dodoc README.commonbox-styles-extra COPYING

}
