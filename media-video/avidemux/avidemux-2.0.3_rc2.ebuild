# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.3_rc2.ebuild,v 1.1 2003/05/23 23:12:59 pylon Exp $

inherit eutils

MY_P=${P/_rc/-}
DESCRIPTION="Great Video editing/encoding tool. New, gtk2 version"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=media-sound/mad-0.14.2b*
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93*
	>=media-video/mjpegtools-1.6*
	>=media-libs/xvid-0.9*
	>=dev-libs/libxml2-2.5.6
	>=x11-libs/gtk+-2.2.1
	>=media-libs/divx4linux-20020418-r1"

S=${WORKDIR}/${MY_P}

src_compile() {
	cd ${S}
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog History README TODO
}
