# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-infinity/xmms-infinity-0.2.ebuild,v 1.1 2002/06/11 23:28:53 george Exp $

DESCRIPTION="A psychedelic visualization plug-in for XMMS"

NAME="infinity"
SRC_URI="http://julien.carme.free.fr/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://julien.carme.free.fr/infinite.html"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsdl-1.2.4-r2
	>=media-sound/xmms-1.2.6-r5"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${NAME}-${PV}

src_compile() {

	econf || die "configure failed"
	emake || die "build failed"
	
}

src_install () {

	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS

}
