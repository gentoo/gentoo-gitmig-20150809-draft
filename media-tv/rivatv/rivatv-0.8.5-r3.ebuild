# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/rivatv/rivatv-0.8.5-r3.ebuild,v 1.2 2005/01/28 01:37:59 cardoe Exp $

inherit linux-mod toolchain-funcs

S=${WORKDIR}/${P/_/-}
DESCRIPTION="kernel driver for nVidia based cards with video-in"
SRC_URI="mirror://sourceforge/rivatv/${P/_/-}.tar.gz"
HOMEPAGE="http://rivatv.sourceforge.net/"
DEPEND="virtual/x11
	>=virtual/linux-sources-2.4.20"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="tuner(media/video:${S}:${S}/bttv) tvmixer(media/video:${S}:${S}/bttv) tvaudio(media/video:${S}:${S}/bttv) rivatv(media/video:${S}:${S}/src) \
	saa7108e(media/video:${S}:${S}/src) saa7111a(media/video:${S}:${S}/src) saa7113h(media/video:${S}:${S}/src) saa7174hl(media/video:${S}:${S}/src) \
	tw98(media/video:${S}:${S}/src) vpx32xx(media/video:${S}:${S}/src)"
BUILD_PARAMS="KSRC=${ROOT}${KV_DIR} KVERS=${KV_MAJOR}${KV_MINOR}"
BUILD_TARGETS="all"
MODULESD_TUNER_ALIASES=("/dev/video0 char-major-81" "/dev/video1 char-major-81" "/dev/video2 char-major-81" "/dev/video3 char-major-81")

src_unpack() {
	unpack ${A}

	# set compiler
	sed -i "s:gcc:$(tc-getCC):" ${S}/Makefile.in

	# fix for new coreutils (#31801)
	sed -i "s:tail -1:tail -n 1:" ${S}/configure

	convert_to_m ${S}/Makefile.in
}


src_compile() {
	econf || die "configure failed"

	linux-mod_src_compile
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "See ${HOMEPAGE} for more information."
}
