# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-0.9.ebuild,v 1.2 2003/04/28 17:12:18 mholzer Exp $

inherit eutils

IUSE="xml2"

MY_P="${P/_/}"
DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.10-r9
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
		`use_enable disable` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog History INSTALL README TODO
}
