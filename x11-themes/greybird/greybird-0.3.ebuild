# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/greybird/greybird-0.3.ebuild,v 1.1 2011/10/28 19:16:09 ssuominen Exp $

EAPI=4

MY_PN=${PN/g/G}

DESCRIPTION="The default theme used in Xubuntu 11.04 Natty"
HOMEPAGE="http://shimmerproject.org/project/greybird/ http://github.com/shimmerproject/Greybird"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_install() {
	dodoc README
	rm -f README

	insinto /usr/share/themes/${MY_PN}
	doins -r *
}
