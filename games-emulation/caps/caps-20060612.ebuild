# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/caps/caps-20060612.ebuild,v 1.5 2007/02/04 18:32:15 blubb Exp $

use amd64 && ABI=x86
inherit eutils multilib

DESCRIPTION="Support library that allows third party applications access and use C.A.P.S. images"
HOMEPAGE="http://www.softpres.org/"
SRC_URI="mirror://gentoo/ipfdevlib_linux-${PV}.tgz
	doc? ( mirror://gentoo/ipfdoc102a.zip )
	mirror://gentoo/config_uae_ocs13_512c-512s.zip"

DEPEND="app-arch/unzip"
LICENSE="CAPS"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"
RESTRICT="nostrip"

S="${WORKDIR}"

src_install() {
	insinto /usr/include/caps
	doins ipfdevlib_linux/include/caps/capsimage.h

	case ${ARCH} in
		ppc)
			dolib.so ipfdevlib_linux/lib/ppc/libcapsimage.so.2.0
			dobin ipfdevlib_linux/examples/ppc/ipfinfo
			;;
		x86|amd64)
			dolib.so ipfdevlib_linux/lib/i686/libcapsimage.so.2.0
			dobin ipfdevlib_linux/examples/i686/ipfinfo
			;;
		*)
			eerror "Unsupported platform"
			;;
	esac
	dosym /usr/$(get_libdir)/libcapsimage.so.2.0 /usr/$(get_libdir)/libcapsimage.so.2

	insinto /usr/share/${PN}
	doins OCS_13_1Mb_800_600.uae
	doins ipfdevlib_linux/examples/ipfinfo.c

	use doc && dodoc CAPSLib102a-40.pdf
	cd ${S}/ipfdevlib_linux
	dodoc HISTORY README || die "doc installation failed"
}
