# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/caps/caps-20040303.ebuild,v 1.3 2005/06/15 11:09:06 dholm Exp $

inherit eutils

S="${WORKDIR}"
DESCRIPTION="Support library that allows third party applications access and use C.A.P.S. images"
HOMEPAGE="http://www.caps-project.org/"
SRC_URI="http://www.caps-project.org/files/ipfdevlib_linux.tgz
	http://www.caps-project.org/files/CAPSLib102a.zip
	http://www.caps-project.org/files/OCS_13_1Mb_800_600.zip"

DEPEND="app-arch/unzip"
LICENSE="CAPS"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""
RESTRICT="nostrip"

src_install() {
	insinto /usr/include/caps
	doins ipfdevlib_linux/include/caps/capsimage.h

	case ${ARCH} in
		ppc)
			dolib.so ipfdevlib_linux/lib/ppc/libcapsimage.so.1.1
			dobin ipfdevlib_linux/examples/ppc/ipfinfo
			;;
		x86|amd64)
			dolib.so ipfdevlib_linux/lib/i686/libcapsimage.so.1.1
			dobin ipfdevlib_linux/examples/i686/ipfinfo
			;;
		*)
			eerror "Unsupported platform"
			;;
	esac
	dosym /usr/lib/libcapsimage.so.1.1 /usr/lib/libcapsimage.so.1

	insinto /usr/share/${PN}
	doins OCS_13_1Mb_800_600.uae
	doins ipfdevlib_linux/examples/ipfinfo.c

	insinto /usr/share/doc/${P}
	doins CAPSLib102a-40.pdf
	cd ${S}/ipfdevlib_linux
	dodoc readme.txt license.txt history.txt || die "doc installation failed"
}
