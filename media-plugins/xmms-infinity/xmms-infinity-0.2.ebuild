# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infinity/xmms-infinity-0.2.ebuild,v 1.5 2004/03/26 22:00:18 eradicator Exp $

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A psychedelic visualization plug-in for XMMS"
SRC_URI="http://julien.carme.free.fr/${MY_P}.tar.gz"
HOMEPAGE="http://julien.carme.free.fr/infinite.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	media-libs/libsdl
	media-sound/xmms"

src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
