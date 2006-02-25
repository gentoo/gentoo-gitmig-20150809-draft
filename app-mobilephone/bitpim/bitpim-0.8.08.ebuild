# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/bitpim/bitpim-0.8.08.ebuild,v 1.1 2006/02/25 12:37:11 mrness Exp $

inherit eutils rpm

DESCRIPTION="BitPim is a program that allows you to view and manipulate data on selected cellular phones."
HOMEPAGE="http://www.bitpim.org"
SRC_URI="mirror://sourceforge/${PN}/${P}-0.i386.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="nostrip"

RDEPEND="=virtual/libstdc++-3.3
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}"

src_install() {
	cd "${S}/usr/bin"
	exeinto /usr/bin
	doexe bitfling bitpim

	cd "${S}/usr/lib"
	insinto /usr/lib
	insopts -m0644
	doins -r "${P}"

	cd "${D}/usr/lib/${P}"
	chmod a+x *.so *.so.* bp helpers/*
}
