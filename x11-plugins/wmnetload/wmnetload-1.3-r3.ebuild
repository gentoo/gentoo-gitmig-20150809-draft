# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r3.ebuild,v 1.1 2009/01/22 14:21:24 s4t4n Exp $

inherit autotools eutils

WANT_AUTOMAKE="1.4"

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64 ~sparc"
IUSE=""

RDEPEND=">=x11-libs/libdockapp-0.6.1"

DEPEND="${RDEPEND}
	=sys-devel/automake-1.4_p6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-${PVR}-norpath.patch"

	eautoconf || die
	eautomake || die
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS README NEWS
}
