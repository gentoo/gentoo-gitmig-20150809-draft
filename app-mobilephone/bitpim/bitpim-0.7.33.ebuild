# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/bitpim/bitpim-0.7.33.ebuild,v 1.2 2005/07/23 21:39:07 mrness Exp $

inherit eutils rpm
DESCRIPTION="BitPim is a program that allows you to view and manipulate data on selected cellular phones."
HOMEPAGE="http://www.bitpim.org"
SRC_URI="mirror://sourceforge/${PN}/${P}-0.i386.rpm"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="${RESTRICT} nostrip"
DEPEND="sys-libs/lib-compat"

S=${WORKDIR}

src_install() {
	cd ${S}/usr/bin
	exeinto /usr/bin
	doexe bitfling bitpim

	cd ${S}/usr/lib/
	insinto /usr/lib/
	doins -r ${P}

	cd ${S}/usr/lib/${P}
	exeinto /usr/lib/${P}
	doexe bp
}
