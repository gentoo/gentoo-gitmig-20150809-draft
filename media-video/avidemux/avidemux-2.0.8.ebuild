# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.8.ebuild,v 1.1 2003/06/28 15:24:52 mholzer Exp $

inherit eutils

DESCRIPTION="Great Video editing/encoding tool. New, gtk2 version"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11
   >=media-sound/mad-0.14.2b*
   >=media-libs/a52dec-0.7.4
   >=media-sound/lame-3.93*
   >=media-video/mjpegtools-1.6*
   >=media-libs/xvid-0.9*
   >=dev-libs/libxml2-2.5.6
   >=x11-libs/gtk+-2.2.1
   >=media-libs/divx4linux-20020418-r1"


S=${WORKDIR}/${P}

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog History README TODO
}
