# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/tirc/tirc-1.2.ebuild,v 1.1 2007/03/13 21:20:36 armin76 Exp $

DESCRIPTION="Tolken's IRC client"
HOMEPAGE="http://home.mayn.de/jean-luc/alt/tirc/"
SRC_URI="mirror://debian/pool/main/t/tirc/${PN}_${PV}.orig.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug"

DEPEND="sys-libs/ncurses"

src_compile() {
	if use debug; then
		myconf="--enable-debug"
	fi

	econf ${myconf}	|| die "econf failed"

	emake depend || die "emake depend failed"
	emake tirc || die "emake tirc failed"
}

src_install() {
	dobin tirc || die "dobin failed"
	doman tirc.1 || die "doman failed"
	dodoc Changelog FAQ Notes README doc/* || die "dodoc failed"
}
