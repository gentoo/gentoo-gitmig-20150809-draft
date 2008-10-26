# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftd2xx/libftd2xx-0.4.13-r1.ebuild,v 1.2 2008/10/26 20:03:14 vapier Exp $

inherit multilib

MY_P="${PN}${PV}"

DESCRIPTION="Library that allows a direct access to a USB device"
HOMEPAGE="http://www.ftdichip.com/"
SRC_URI="http://www.ftdichip.com/Drivers/D2XX/Linux/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	has_multilib_profile && ABI="x86"
}

src_install() {
	local ftdifile="${PN}.so.${PV}"
	local ftdisym="${PN}.so.0 ${PN}.so"

	insinto /usr/include
	doins ftd2xx.h || die "doins failed"
	doins WinTypes.h || die "doins failed"

	dolib.so ${ftdifile} || die "dolib.so failed"
	local i
	for i in ${ftdisym} ; do
		dosym ${ftdifile} /usr/$(get_libdir)/${i}
	done

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r sample || die "doins failed"
		insinto /usr/share/doc/${PF}/sample
		doins -r lib_table || die "doins failed"
	fi

	dodoc Config.txt FAQ.txt README.dat
}
