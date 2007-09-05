# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/wengophone-bin/wengophone-bin-2.1.2.ebuild,v 1.1 2007/09/05 21:32:42 tester Exp $

inherit	eutils

MY_PN="WengoPhone"
DESCRIPTION="Wengophone NG is a VoIP client featuring the SIP protocol"
HOMEPAGE="http://www.openwengo.org/"
SRC_URI="http://download.wengo.com/wengophone/release/2007-08-24/${MY_PN}-${PV/_/-}-linux-bin-x86.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="strip"

DEPEND=""
RDEPEND="${DEPEND}
	!net-im/wengophone
	amd64? ( app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-xlibs
			app-emulation/emul-linux-x86-soundlibs )
	x86? (
		=dev-libs/openssl-0.9.8*
		sys-libs/zlib
		=dev-libs/glib-2*
		media-libs/alsa-lib
		media-libs/libsndfile
		sys-fs/e2fsprogs
		dev-libs/libxml2
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXrender
	)"

S=${WORKDIR}/WengoPhone-${PV}-minsizerel

QA_TEXTRELS="opt/wengophone/libwebcam.so
	opt/wengophone/libphapi.so
	opt/wengophone/libowwebcam.so
	opt/wengophone/libcoredumper.so
	opt/wengophone/libphamrplugin.so
	opt/wengophone/libsfp-plugin.so"

src_install() {
	local WENGO_HOME="/opt/wengophone"

	dodir "${WENGO_HOME}"

	insinto "${WENGO_HOME}"
	doins -r {emoticons,lang,pics,sounds}

	insopts -m0755
	insinto "${WENGO_HOME}"
	doins *.so*

	exeinto "${WENGO_HOME}"
	doexe qtwengophone

	make_wrapper "wengophone" "./qtwengophone" "${WENGO_HOME}" "${WENGO_HOME}" /opt/bin

	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry "wengophone" "WengoPhone"
}
