# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

MY_TV=${PV%.*}	# 0.7.1 -> 0.7
DESCRIPTION="Tetrinet Clone for GNOME 2"
SRC_URI="mirror://gnome/sources/gtetrinet/${MY_TV}/${P}.tar.gz"
HOMEPAGE="http://gtetrinet.sourceforge.net/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="nls ipv6"

RDEPEND="dev-libs/libxml2
	>=media-sound/esound-0.2.5
	>=gnome-base/gconf-2*
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf `use_enable ipv6` || die
	emake || die "Compilation failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	# move some stuff around
	cd ${D}/${GAMES_PREFIX}
	mkdir bin && mv games/gtetrinet bin/
	rm -rf games
	cd ${D}/${GAMES_DATADIR}
	mv applications locale pixmaps ../
	use nls || rm -rf locale

	prepgamesdirs
}
