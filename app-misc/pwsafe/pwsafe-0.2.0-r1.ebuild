# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pwsafe/pwsafe-0.2.0-r1.ebuild,v 1.1 2011/04/13 08:43:50 nirbheek Exp $

EAPI=2
inherit eutils

DESCRIPTION="A Password Safe compatible command-line password manager"
HOMEPAGE="http://nsd.dyndns.org/pwsafe/"
SRC_URI="http://nsd.dyndns.org/pwsafe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="X readline"

DEPEND="sys-libs/ncurses
	dev-libs/openssl
	readline? ( sys-libs/readline )
	X? ( x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXmu
		x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-cvs-1.57.patch"
	epatch "${FILESDIR}/${P}-printf.patch"
	epatch "${FILESDIR}/${P}-fake-readline.patch"
	epatch "${FILESDIR}/${P}-man-page-option-syntax.patch"
}

src_configure() {
	econf $(use_with X x) $(use_with readline) || die
}

src_compile() {
	emake || die
}

src_install() {
	doman pwsafe.1 || die
	dobin pwsafe || die
	dodoc README NEWS || die
}
