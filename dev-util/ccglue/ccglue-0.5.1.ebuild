# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccglue/ccglue-0.5.1.ebuild,v 1.2 2012/05/31 14:09:52 radhermit Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Produce cross-reference files from cscope and ctags for use with app-vim/cctree"
HOMEPAGE="http://ccglue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-release-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}_v${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags.patch
	eautoreconf
}
