# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/makemkv/makemkv-1.7.6.ebuild,v 1.3 2012/07/04 09:08:02 ssuominen Exp $

EAPI=4
inherit eutils gnome2-utils multilib

MY_P=makemkv-oss-${PV}
MY_PB=makemkv-bin-${PV}

DESCRIPTION="Tool for ripping Blu-Ray, HD-DVD and DVD discs and copying content to a Matroska container"
HOMEPAGE="http://www.makemkv.com/"
SRC_URI="http://www.makemkv.com/download/${MY_P}.tar.gz
	http://www.makemkv.com/download/${MY_PB}.tar.gz"

LICENSE="MakeMKV-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

QA_PREBUILT=opt/bin/makemkvcon
RESTRICT=mirror

RDEPEND="dev-libs/expat
	dev-libs/openssl:0
	sys-libs/zlib
	virtual/opengl
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

DEFAULT_PROFILE=default.mmcp.xml

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.linux.patch
}

src_compile() {
	emake GCC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" -f makefile.linux
}

src_install() {
	# install oss package
	dolib.so out/libdriveio.so.0
	dolib.so out/libmakemkv.so.1
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so.0.${PV}
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so.1.${PV}
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so
	into /opt
	dobin out/makemkv

	local res
	for res in 16 22 32 64 128; do
		newicon -s ${res} makemkvgui/src/img/${res}/mkv_icon.png ${PN}.png
	done

	make_desktop_entry ${PN} MakeMKV ${PN} 'Qt;AudioVideo;Video'

	# install bin package
	pushd "${WORKDIR}"/${MY_PB}/bin >/dev/null
	if use x86; then
		dobin i386/makemkvcon
	elif use amd64; then
		dobin amd64/makemkvcon
	fi
	popd >/dev/null

	# install license and default profile
	pushd "${WORKDIR}"/${MY_PB}/src >/dev/null
	insinto /usr/share/${PF}
	doins share/${DEFAULT_PROFILE}
	popd >/dev/null
}

pkg_preinst() {	gnome2_icon_savelist; }

pkg_postinst() {
	gnome2_icon_cache_update

	elog "While MakeMKV is in beta mode, upstream has provided a license"
	elog "to use if you do not want to purchase one."
	elog ""
	elog "See this forum thread for more information, including the key:"
	elog "http://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053"
	elog ""
	elog "Note that beta license may have an expiration date and you will"
	elog "need to check for newer licenses/releases. "
	elog ""
	elog "If this is a new install, remember to copy the default profile"
	elog "to the config directory:"
	elog "cp /usr/share/${PF}/${DEFAULT_PROFILE} ~/.MakeMKV/${DEFAULT_PROFILE}"
}

pkg_postrm() { gnome2_icon_cache_update; }
