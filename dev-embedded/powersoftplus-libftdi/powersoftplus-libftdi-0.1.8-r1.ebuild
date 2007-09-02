# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/powersoftplus-libftdi/powersoftplus-libftdi-0.1.8-r1.ebuild,v 1.1 2007/09/02 19:09:20 jurek Exp $

inherit multilib

MY_PN="${PN/-libftdi/}"
MY_P="${MY_PN}-${PV}"

TABFILE="libd2xx_table.so"
TABFILEDIR="libftdi/lib_table"

DESCRIPTION="Library which includes a table of VIDs and PIDs of Ever UPS devices"
HOMEPAGE="http://www.ever.com.pl"
SRC_URI="http://www.ever.com.pl/pl/pliki/${MY_P}-x86.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cd "${TABFILEDIR}"

	# Wipe out precompiled binary
	emake clean || die "emake failed"
	emake || die "emake failed"
}

src_install() {
	ftditabfile="${TABFILEDIR}/${TABFILE}"
	dolib.so ${ftditabfile} || die "dolib.so failed"
}
