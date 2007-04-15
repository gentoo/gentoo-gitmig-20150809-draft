# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beep/beep-1.2.2-r1.ebuild,v 1.7 2007/04/15 19:50:32 corsair Exp $

inherit eutils base

DESCRIPTION="the advanced PC speaker beeper"
HOMEPAGE="http://www.johnath.com/beep/"
SRC_URI="http://www.johnath.com/beep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-nosuid.patch"

src_compile() {
	emake FLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	dobin beep
	fperms 0711 /usr/bin/beep
	doman beep.1.gz
	dodoc CHANGELOG CREDITS README
}
