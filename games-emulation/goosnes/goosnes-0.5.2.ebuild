# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/goosnes/goosnes-0.5.2.ebuild,v 1.7 2004/11/11 01:37:04 josejx Exp $

DESCRIPTION="A GTK+ frontend for Snes9X"
HOMEPAGE="http://bard.sytes.net/goosnes/"
SRC_URI="http://bard.sytes.net/debian/dists/unstable/main/source/${PN}_${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="gtk2"

DEPEND="|| (
	gtk2? ( =x11-libs/gtk+-2* )
	=x11-libs/gtk+-1*
	)
	dev-libs/libxml2"
RDEPEND="${DEPEND}
	games-emulation/snes9x"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	use gtk2 && myconf="--with-gtk-version=2.0"
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
