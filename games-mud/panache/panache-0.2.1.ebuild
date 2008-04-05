# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/panache/panache-0.2.1.ebuild,v 1.9 2008/04/05 23:22:17 nyhm Exp $

inherit autotools games

DESCRIPTION="Gnome TinyFugue port"
HOMEPAGE="http://panache.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/gtk+-2
	media-libs/libart_lgpl
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	dev-libs/libxml2
	>=gnome-base/orbit-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf # replace automake symlinks
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
