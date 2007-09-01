# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/powersoftplus-libftdi/powersoftplus-libftdi-0.1.8.ebuild,v 1.1 2007/09/01 23:39:13 jurek Exp $

inherit autotools multilib

MY_PN="${PN/-libftdi/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A version of FTDI libraries prepared for use with Ever UPS daemon"
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
	cd libftdi/lib_table

	# Recompile lib_table
	emake clean || die "emake failed"
	emake || die "emake failed"
}

src_install() {
	ftditabfile="lib_table/libd2xx_table.so"
	ftdifile="libftd2xx.so.0.4.10"
	ftdisym="libftd2xx.so.0 libftd2xx.so"

	cd libftdi

	dolib.so ${ftditabfile}
	dolib.so ${ftdifile}
	for i in ${ftdisym}
	do
		dosym ${ftdifile} /usr/$(get_libdir)/${i}
	done
}
