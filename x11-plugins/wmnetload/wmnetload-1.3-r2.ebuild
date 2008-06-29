# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r2.ebuild,v 1.5 2008/06/29 13:24:17 drac Exp $

inherit eutils

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64 sparc"
IUSE=""

DEPEND="x11-libs/libdockapp"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add support for libdockapp 0.5
	epatch "${FILESDIR}"/add_support_for_libdockapp_0.5.patch

	epatch "${FILESDIR}"/wmnetload-1.3-norpath.patch
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS README NEWS
}
