# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/binclock/binclock-1.4.ebuild,v 1.1 2004/07/10 21:04:13 swegener Exp $

DESCRIPTION="Displays a binary clock in your terminal"
HOMEPAGE="http://www.ngolde.de/binclock/"
SRC_URI="http://www.ngolde.de/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e s/strip/echo/ Makefile
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin binclock || die "dobin failed"
	doman doc/binclock.1 || die "doman failed"
	dodoc CHANGELOG README binclockrc || die "dodoc failed"
}
