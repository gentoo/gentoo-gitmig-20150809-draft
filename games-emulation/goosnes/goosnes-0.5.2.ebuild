# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/goosnes/goosnes-0.5.2.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION="A GTK+ frontend for Snes9X"
SRC_URI="http://bard.sytes.net/debian/dists/unstable/main/source/${PN}_${PV}-1.tar.gz"
HOMEPAGE="http://bard.sytes.net/goosnes/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="gtk2"

DEPEND="|| (
	gtk2? ( =x11-libs/gtk+-2* )
	=x11-libs/gtk+-1*
	)
	dev-util/pkgconfig
	dev-libs/libxml2"
RDEPEND="games-emulation/snes9x"

src_compile() {
	use gtk2 && myconf="--with-gtk-version=2.0"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README
}
