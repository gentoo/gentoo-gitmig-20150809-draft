# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-2.0.0-r1.ebuild,v 1.8 2004/07/14 20:24:34 agriffis Exp $

inherit flag-o-matic gcc eutils

DESCRIPTION="quicktime library for linux"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 -ppc ~sparc ~amd64"
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
	!virtual/quicktime"
PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf decore2 encore2 ffmpeg-0.4.6 jpeg jpeg-mmx-0.1.4 \
		lame-3.93.1 libdv-0.99 libogg-1.0 libvorbis-1.0
	ln -s /usr/include jpeg
	epatch ${FILESDIR}/${PV}-external-libs.patch
	[ `gcc-major-version` -eq 2 ] && epatch ${FILESDIR}/${PV}-gcc2.patch
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
