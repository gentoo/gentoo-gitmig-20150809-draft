# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tsmuxer/tsmuxer-1.10.6.ebuild,v 1.1 2010/07/28 00:54:12 sbriesen Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Utility to create TS and M2TS files"
HOMEPAGE="http://www.smlabs.net/tsmuxer_en.html"
SRC_URI="http://www.smlabs.net/tsMuxer/tsMuxeR_shared_${PV}.tar.gz"
LICENSE="SmartLabs"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="gui linguas_ru"

RESTRICT="strip"

DEPEND="gui? (
			x86? ( x11-libs/qt-gui:4 )
			amd64? ( app-emulation/emul-linux-x86-qtlibs )
		)"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /opt/bin
	exeinto /opt/tsMuxeR/bin

	doexe tsMuxeR
	dosym ../tsMuxeR/bin/tsMuxeR /opt/bin

	if use gui; then
		doexe tsMuxerGUI
		dosym ../tsMuxeR/bin/tsMuxerGUI /opt/bin
		newicon ${FILESDIR}/icon.png tsMuxerGUI.png
		make_desktop_entry tsMuxerGUI tsMuxerGUI tsMuxerGUI
	fi

	dodoc licence.txt  # is this needed?
	use linguas_ru && dodoc readme.rus.txt
}
