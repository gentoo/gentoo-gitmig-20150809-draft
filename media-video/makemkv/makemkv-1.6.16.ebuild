# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/makemkv/makemkv-1.6.16.ebuild,v 1.1 2011/12/02 20:32:19 beandog Exp $

EAPI=3

RESTRICT="mirror"

inherit multilib eutils

MY_P="makemkv_v${PV}_oss"
MY_PB="makemkv_v${PV}_bin"

DESCRIPTION="Tool for converting Blu-Ray, HD-DVD and DVD videos to matroska."
HOMEPAGE="http://www.makemkv.com"
SRC_URI="http://www.makemkv.com/download/makemkv_v${PV}_oss.tar.gz
	http://www.makemkv.com/download/makemkv_v${PV}_bin.tar.gz"

LICENSE="MakeMKV-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui
	dev-libs/openssl
	media-libs/mesa
	x11-libs/qt-dbus"
src_prepare() {
	cd "${MY_P}"
}

src_compile() {
	cd "${MY_P}"
	emake GCC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" -f makefile.linux || die "make failed"
}

src_install() {
	# install oss package
	cd "${MY_P}"
	dolib.so out/libdriveio.so.0
	dolib.so out/libmakemkv.so.1
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so.0.${PV}
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so.1.${PV}
	into /usr
	dobin out/makemkv

	newicon makemkvgui/src/img/128/mkv_icon.png ${PN}.png
	make_desktop_entry ${PN} "MakeMKV" ${PN} "Qt;AudioVideo;Video"

	# install bin package
	cd "../${MY_PB}/bin"
	if use x86; then
		dobin i386/makemkvcon
	elif use amd64; then
		dobin amd64/makemkvcon
	fi
}

pkg_postinst() {
	elog "While MakeMKV is in beta mode, upstream has provided a license"
	elog "to use if you do not want to purchase one."
	elog ""
	elog "See this forum thread for more information, including the key:"
	elog "http://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053"
}
