# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/makemkv/makemkv-1.7.4-r1.ebuild,v 1.1 2012/07/02 03:46:19 mattm Exp $

EAPI=3

RESTRICT="mirror"

inherit multilib eutils

MY_P="makemkv_v${PV}_oss"
MY_PB="makemkv_v${PV}_bin"

DESCRIPTION="Tool for ripping Blu-Ray, HD-DVD and DVD discs and copying content to a Matroska container"
HOMEPAGE="http://www.makemkv.com/"
SRC_URI="http://www.makemkv.com/download/${MY_P}.tar.gz
	http://www.makemkv.com/download/${MY_PB}.tar.gz"

LICENSE="MakeMKV-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	dev-libs/openssl:0
	media-libs/mesa
	dev-libs/expat
	x11-libs/qt-dbus:4
	sys-libs/zlib"
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/bin/makemkvcon"
DEFAULT_PROFILE="default.mmcp.xml"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.linux.patch"
	cd "${MY_P}"
}

src_compile() {
	cd "${MY_P}"
	emake GCC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" -f makefile.linux || die "make failed"
}

src_install() {
	# install oss package
	cd "${MY_P}"
	dolib.so out/libdriveio.so.0 || die "dolib.so out/libdriveio.so.0 died"
	dolib.so out/libmakemkv.so.1 || die "dolib.so out/libmakemkv.so.1 died"
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so.0.${PV} || die "dosym libdriveio.so.0 died "
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so || die "dosym libdriveio.so.0 died "
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so.1.${PV} || die "dosym libmakemkv.so.1 died"
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so || die "dosym libmakemkv.so.1 died"
	into /opt
	dobin out/makemkv || die "dobin makemkv died"

	newicon makemkvgui/src/img/128/mkv_icon.png ${PN}.png
	make_desktop_entry ${PN} "MakeMKV" ${PN} "Qt;AudioVideo;Video"

	# install bin package
	cd "${WORKDIR}/${MY_PB}/bin"
	if use x86; then
		dobin i386/makemkvcon || die "dobin makemkvcon died"
	elif use amd64; then
		dobin amd64/makemkvcon || die "dobin makemkvcon died"
	fi

	# install license and default profile
	cd "${WORKDIR}/${MY_PB}/src"
	into /usr
	dodoc eula_en_linux.txt
	insinto /usr/share/${PF}
	doins share/${DEFAULT_PROFILE}
}

pkg_postinst() {
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
