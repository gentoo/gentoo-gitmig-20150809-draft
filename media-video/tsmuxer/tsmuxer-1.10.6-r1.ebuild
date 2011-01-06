# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tsmuxer/tsmuxer-1.10.6-r1.ebuild,v 1.3 2011/01/06 03:35:17 vapier Exp $

EAPI="2"

inherit base qt4-r2

DESCRIPTION="Utility to create and demux TS and M2TS files"
HOMEPAGE="http://www.smlabs.net/tsmuxer_en.html"
SRC_URI="http://www.smlabs.net/tsMuxer/tsMuxeR_shared_${PV}.tar.gz"
LICENSE="SmartLabs"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="qt4 linguas_ru"

QA_DT_HASH="opt/${PN}/bin/tsMuxeR opt/${PN}/bin/tsMuxerGUI"

DEPEND="|| (
	>=app-arch/upx-ucl-3.01
	>=app-arch/upx-bin-3.01
)"
RDEPEND="
	x86? (
		media-libs/freetype:2
		qt4? (
			x11-libs/qt-gui:4
			media-libs/libpng:1.2
		)
		sys-libs/glibc
	)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		qt4? ( >=app-emulation/emul-linux-x86-qtlibs-20081109 )
	)"

# cli is linked to freetype, when it will be fixed,
# we will remove app-emulation/emul-linux-x86-xlibs dep.

S="${WORKDIR}"

src_prepare() {
	upx -d tsMuxeR tsMuxerGUI || die
}

src_install() {
	dodir /opt/bin
	exeinto /opt/${PN}/bin

	doexe tsMuxeR
	dosym ../${PN}/bin/tsMuxeR /opt/bin

	if use qt4; then
		doexe tsMuxerGUI
		dosym ../${PN}/bin/tsMuxerGUI /opt/bin
		newicon "${FILESDIR}/icon.png" "${PN}.png"
		make_desktop_entry tsMuxerGUI "tsMuxeR GUI" "${PN}" "Qt;AudioVideo;Video"
	fi

	use linguas_ru && dodoc readme.rus.txt
}
