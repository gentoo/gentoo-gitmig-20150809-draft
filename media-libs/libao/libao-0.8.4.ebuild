# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.4.ebuild,v 1.12 2005/01/30 00:00:26 chainsaw Exp $

inherit eutils

IUSE="esd"

DESCRIPTION="the audio output library"
SRC_URI="http://www.xiph.org/ao/src/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa amd64 ~mips"

DEPEND="virtual/libc
	!mips? ( esd? ( >=media-sound/esound-0.2.22 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}/src/plugins/alsa09
	epatch ${FILESDIR}/alsa-1.0.patch
}

src_compile() {
	econf \
		--enable-shared \
		--enable-static || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES COPYING README TODO
	dohtml -A c doc/*.html
}
