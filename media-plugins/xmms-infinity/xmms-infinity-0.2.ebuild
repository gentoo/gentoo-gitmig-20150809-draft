# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infinity/xmms-infinity-0.2.ebuild,v 1.11 2004/07/14 20:42:38 agriffis Exp $

inherit gnuconfig

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A psychedelic visualization plug-in for XMMS"
SRC_URI="http://julien.carme.free.fr/${MY_P}.tar.gz"
HOMEPAGE="http://julien.carme.free.fr/infinite.html"

SLOT="0"
LICENSE="GPL-2"
#-sparc: 0.2: always black - eradicator
KEYWORDS="x86 ~ppc amd64 -sparc"

IUSE=""

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	media-libs/libsdl
	media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
