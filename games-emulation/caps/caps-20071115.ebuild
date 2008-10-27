# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/caps/caps-20071115.ebuild,v 1.1 2008/10/27 20:44:45 tupone Exp $

inherit eutils multilib

DESCRIPTION="Support library that allows third party applications access and use C.A.P.S. images"
HOMEPAGE="http://www.softpres.org/"
SRC_URI="mirror://gentoo/ipfdevlib_linux-20060612.tgz
	x86? ( ipflib_linux-i686-${PV}.tgz )
	amd64? ( ipflib_linux-amd64-${PV}.tgz )
	ppc? ( ipflib_linux-ppc-${PV}.tgz )
	doc? ( mirror://gentoo/ipfdoc102a.zip )
	mirror://gentoo/config_uae_ocs13_512c-512s.zip"

LICENSE="CAPS"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_install() {
	local myArch=${ARCH}

	insinto /usr/include/caps
	doins ipfdevlib_linux/include/caps/capsimage.h || die

	case ${ARCH} in
		ppc|amd64)
			;;
		x86)
			myArch=i686
			;;
		*)
			eerror "Unsupported platform"
			;;
	esac
	dolib.so ipflib_linux-${myArch}/libcapsimage.so.2.3 || die
	dobin ipflib_linux-${myArch}/ipfinfo || die

	dosym /usr/$(get_libdir)/libcapsimage.so.2.3 \
		/usr/$(get_libdir)/libcapsimage.so.2

	insinto /usr/share/${PN}
	doins OCS_13_1Mb_800_600.uae || die
	doins ipfdevlib_linux/examples/ipfinfo.c || die

	use doc && dodoc CAPSLib102a-40.pdf
	dodoc ipflib_linux-${myArch}/{HISTORY,README}
}
