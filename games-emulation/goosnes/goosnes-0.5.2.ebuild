# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/goosnes/goosnes-0.5.2.ebuild,v 1.8 2005/07/22 00:11:21 vapier Exp $

inherit games

DESCRIPTION="A GTK+ frontend for Snes9X"
HOMEPAGE="http://bard.sytes.net/goosnes/"
SRC_URI="http://bard.sytes.net/debian/dists/unstable/main/source/${PN}_${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk2"

DEPEND="dev-libs/libxml2
	gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1* )"
RDEPEND="${DEPEND}
	games-emulation/snes9x"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# packaging is broken
	aclocal && autoheader && autoconf && automake || die
}

src_compile() {
	use gtk2 && myconf="--with-gtk-version=2.0"
	egamesconf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
