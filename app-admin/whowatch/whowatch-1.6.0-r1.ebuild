# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.6.0-r1.ebuild,v 1.2 2012/02/05 18:22:23 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="
	http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz
	mirror://debian/pool/main/w/whowatch/${P/-/_}a-2.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${P/-/_}a-2.diff
	epatch "${WORKDIR}"/${P}/${P}a/debian/whowatch-1.6.0.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
	epatch "${FILESDIR}"/${P}-submenus.patch
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
