# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/acovea/acovea-5.1.1.ebuild,v 1.1 2006/06/27 23:46:07 exg Exp $

inherit autotools

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm"
HOMEPAGE="http://www.coyotegulch.com/products/acovea/"
SRC_URI="http://www.coyotegulch.com/distfiles/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/libcoyotl
	dev-libs/libevocosm
	dev-libs/expat"
DEPEND="${RDEPEND}"

S=${WORKDIR}/lib${P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	epatch "${FILESDIR}"/${P}-free-fix.patch
	eautomake
}

src_install() {
	make DESTDIR="${D}" install
	dodoc ChangeLog NEWS README
}
