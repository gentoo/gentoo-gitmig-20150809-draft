# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unp/unp-1.0.9.ebuild,v 1.4 2004/06/24 21:37:48 agriffis Exp $

DESCRIPTION="Script for unpacking various file formats"
HOMEPAGE="http://packages.qa.debian.org/u/unp.html"
SRC_URI="mirror://debian/pool/main/u/unp/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lang/perl"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin unp
}
