# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.6.ebuild,v 1.2 2003/08/06 13:30:14 vapier Exp $

# Kino 0.6 is newer than 0.51, but portage cannot handle this
MY_PV="0.6"
DESCRIPTION="kino is a digital video editor for linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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

S=${WORKDIR}/${PN}-${MY_PV}

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

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	echo "To use kino, it is recommed that you also install"
	echo "media-video/mjpegtools"
}
