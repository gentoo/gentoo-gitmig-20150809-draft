# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.7.0.ebuild,v 1.2 2004/03/17 21:11:30 dholm Exp $

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"
IUSE="quicktime"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="x11-libs/gtk+
	gnome-base/libglade
	gnome-base/libgnomeui
	dev-libs/glib
	gnome-base/gnome-libs
	media-libs/imlib
	dev-libs/libxml2
	media-libs/audiofile
	media-sound/esound
	sys-libs/libraw1394
	sys-libs/libavc1394
	media-libs/libdv
	quicktime? ( virtual/quicktime )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-debug \
		`use-with quicktime` || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	echo "To use kino, it is recommed that you also install"
	echo "media-video/mjpegtools"
}
