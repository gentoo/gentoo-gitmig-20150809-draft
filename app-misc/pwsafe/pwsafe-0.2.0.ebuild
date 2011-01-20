# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pwsafe/pwsafe-0.2.0.ebuild,v 1.6 2011/01/20 22:08:36 hwoarang Exp $

inherit eutils

DESCRIPTION="PasswordSafe Compatible Commandline Password Manager"
HOMEPAGE="http://nsd.dyndns.org/pwsafe/"
SRC_URI="http://nsd.dyndns.org/pwsafe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="X readline"

DEPEND="sys-libs/ncurses
	dev-libs/openssl
	readline? ( sys-libs/readline )
	X? ( x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXmu
		x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with X x) $(use_with readline)
	emake
}

src_install() {
	doman pwsafe.1
	dobin pwsafe
	dodoc README NEWS
}
