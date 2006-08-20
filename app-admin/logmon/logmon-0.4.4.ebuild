# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logmon/logmon-0.4.4.ebuild,v 1.8 2006/08/20 18:02:48 malc Exp $

inherit eutils

MY_P="LogMon-${PV}"
DESCRIPTION="Split-screen terminal/ncurses based log viewer"
HOMEPAGE="http://www.edespot.com/code/LogMon/"
SRC_URI="http://www.edespot.com/code/LogMon/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 119403 - should be in upstream next release
	epatch "${FILESDIR}"/${PN}-0.4.4-char2int.diff
}

src_install() {
	dobin logmon || die
	dodoc AUTHORS ChangeLog README TODO
}
