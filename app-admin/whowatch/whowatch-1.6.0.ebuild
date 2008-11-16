# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.6.0.ebuild,v 1.2 2008/11/16 15:21:27 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-debian.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
}

src_compile() {
	tc-export CC

	# This is were Debian sets -O0:
	CFLAGS="${CFLAGS} -fno-unit-at-a-time"

	econf || die "econf failed"
	emake || die
}

src_install() {
	dobin src/${PN} || die "dobin failed"
	doman ${PN}.1
	dodoc AUTHORS ChangeLog README TODO
}
