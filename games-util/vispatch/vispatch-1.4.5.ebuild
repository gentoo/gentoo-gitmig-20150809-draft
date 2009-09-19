# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/vispatch/vispatch-1.4.5.ebuild,v 1.2 2009/09/19 11:40:33 maekke Exp $

EAPI=2
inherit games

DESCRIPTION="WaterVIS utility for glquake"
HOMEPAGE="http://vispatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/vispatch/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P}/source

src_prepare() {
	sed -i \
		-e '/^CFLAGS/d' \
		-e '/^LDFLAGS/d' \
		makefile \
		|| die "sed failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc ${PN}.txt || die "dodoc failed"
}
