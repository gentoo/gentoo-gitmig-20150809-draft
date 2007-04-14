# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/wengophone-bin/wengophone-bin-2.1_rc2.ebuild,v 1.1 2007/04/14 12:48:27 genstef Exp $

inherit	eutils

MY_PN="WengoPhone"
DESCRIPTION="Wengophone NG is a VoIP client featuring the SIP protcol"
HOMEPAGE="http://www.openwengo.org/"
SRC_URI="http://download.wengo.com/releases/${MY_PN}-${PV/_*}/RC${PV/*rc}/linux/${MY_PN}-${PV/_/-}-linux-bin-x86.tar.bz2
	amd64? (
		mirror://debian/pool/main/libg/libgcrypt11/libgcrypt11_1.2.4-1_i386.deb
		mirror://debian/pool/main/libg/libgpg-error/libgpg-error0_1.4-2_i386.deb
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="strip"

DEPEND="amd64? ( app-arch/dpkg )"
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

S=${WORKDIR}

QA_TEXTRELS="opt/wengophone/libwebcam.so
	opt/wengophone/libphapi.so
	opt/wengophone/libsfp-plugin.so"

src_unpack() {
	for pkg in ${A}
	do
		echo ${pkg} | grep -q "tar.bz2" && unpack ${pkg}
		echo ${pkg} | grep -q ".deb" && /usr/bin/dpkg --extract ${DISTDIR}/$pkg ${WORKDIR}
	done
}

src_install() {
	local \
		WENGO_HOME="/opt/wengophone"
		WENGO_SRC="wengophone-ng-binary-latest"

	dodir "${WENGO_HOME}"

	insinto "${WENGO_HOME}"
	doins -r ${WENGO_SRC}/{emoticons,lang,pics,sounds}

	insopts -m0755
	insinto "${WENGO_HOME}"
	doins ${WENGO_SRC}/*.so*
	use amd64 && doins usr/lib/*

	exeinto "${WENGO_HOME}"
	doexe ${WENGO_SRC}/qtwengophone

	use amd64 && rm ${D}/${WENGO_HOME}/lib{gcrypt.so.11.2.3,gpg-error.so.0.3.0}
	rm ${D}/${WENGO_HOME}/{emoticons,sounds}/CMakeLists.txt

	make_wrapper "wengophone" "./qtwengophone" "${WENGO_HOME}" "${WENGO_HOME}" /usr/bin

	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry "wengophone" "WengoPhone"
}
