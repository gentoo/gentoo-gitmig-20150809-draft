# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-2.0.0-r1.ebuild,v 1.11 2005/05/15 02:25:09 flameeyes Exp $

inherit flag-o-matic toolchain-funcs eutils

PATCHLEVEL="3"
DESCRIPTION="quicktime library for linux"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2
	http://digilander.libero.it/dgp85/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 -ppc ~amd64"
IUSE=""

DEPEND="media-libs/jpeg
	media-libs/libpng
	>=media-libs/libmpeg3-1.5.1
	>=media-libs/libdv-0.99
	>=media-video/ffmpeg-0.4.6
	>=media-sound/lame-3.93.1
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	x86? ( media-libs/divx4linux )
	media-libs/a52dec
	!virtual/quicktime
	dev-lang/nasm"
PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf decore2 encore2 ffmpeg-0.4.6 jpeg jpeg-mmx-0.1.4 \
		lame-3.93.1 libdv-0.99 libogg-1.0 libvorbis-1.0
	ln -s /usr/include jpeg

	[ `gcc-major-version` -eq 2 ] || EPATCH_EXCLUDE="00_all_gcc2.patch"
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}
}

src_compile() {
	make MYCFLAGS="${CFLAGS}" || die
	make util MYCFLAGS="${CFLAGS}" || die
}

src_install() {
	dolib.so `uname -m`/libquicktime.so
	dolib.a  `uname -m`/libquicktime.a
	insinto /usr/include/quicktime
	doins *.h
	dodoc README
	dohtml -r docs
}
