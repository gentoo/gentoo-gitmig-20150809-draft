# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.2.ebuild,v 1.1 2003/05/20 00:25:20 pylon Exp $

inherit eutils

MY_P="${P/_/}"
DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="xml2 debug"

DEPEND="virtual/x11
	>=x11-libs/gtk+-2.0
	>=media-sound/mad-0.14.2b*
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93*
	>=media-video/mjpegtools-1.6*
	xml2? ( <=dev-libs/libxml2-2.5.6 )
	>=media-libs/xvid-0.9*
	>=media-libs/divx4linux-20020418-r1"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--disable-warnings \
		`use_enable debug` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog History INSTALL README TODO
}
