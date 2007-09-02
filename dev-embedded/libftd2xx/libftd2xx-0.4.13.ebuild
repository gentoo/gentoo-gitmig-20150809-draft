# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftd2xx/libftd2xx-0.4.13.ebuild,v 1.1 2007/09/02 19:05:52 jurek Exp $

inherit multilib

MY_P="${PN}${PV}"

DESCRIPTION="Library that allows a direct access to a USB device"
HOMEPAGE="http://www.ftdichip.com/"
SRC_URI="http://www.ftdichip.com/Drivers/D2XX/Linux/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	ftdifile="${PN}.so.${PV}"
	ftdisym="${PN}.so.0 ${PN}.so"

	insinto /usr/include || die "insinto failed"
	doins ftd2xx.h || die "doins failed"

	dolib.so ${ftdifile} || die "dolib.so failed"
	for i in ${ftdisym}
	do
		dosym ${ftdifile} /usr/$(get_libdir)/${i}
	done

	if use examples; then
		insinto /usr/share/doc/${PF} || die "insinto failed"
		doins -r sample || die "doins failed"
		insinto /usr/share/doc/${PF}/sample || die "insinto failed"
		doins -r lib_table || die "doins failed"
	fi

	dodoc Config.txt FAQ.txt README.dat
}
