# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-0.9_pre28.ebuild,v 1.1 2003/01/09 12:58:33 mholzer Exp $

MY_P="${P/_/}"
DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/x11
	>=media-sound/mad-0.14.2b-r2
	>=media-sound/lame-3.93.1
	<=media-sound/esound-0.2.29
	>=media-libs/libmpeg3-1.5-r1
	>=media-libs/a52dec-0.7.4
	>=media-libs/divx4linux-20020418-r1
	>=x11-libs/gtk+-1.2.10-r9
	>=media-video/mjpegtools-1.6.0-r5"


src_compile() {
	#Doesn't like more than -O2
	CFLAGS="`echo ${CFLAGS} | sed "s/ -O[3-9]/ -O2/g"`"
	CXXFLAGS="`echo ${CXXFLAGS} | sed "s/ -O[3-9]/ -O2/g"`"

	econf --disable-warnings
	#make || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog History README TODO
}
