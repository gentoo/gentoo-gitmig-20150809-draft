# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.51.ebuild,v 1.1 2002/10/14 13:41:09 hanno Exp $

DESCRIPTION="kino is a digital video editor for linux"
HOMEPAGE="http://kino.schirmacher.de/"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}-1.tar.gz"
S=${WORKDIR}/${P}

DEPEND="x11-libs/gtk+
	dev-libs/glib
	gnome-base/gnome-libs
	media-libs/imlib
	dev-libs/libxml2
	media-libs/audiofile
	media-sound/esound
	sys-libs/libraw1394
	sys-libs/libavc1394
	media-libs/libdv"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-dependency-tracking \
		--disable-debug || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
