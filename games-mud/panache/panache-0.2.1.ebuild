# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/panache/panache-0.2.1.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

DESCRIPTION="Gnome TinyFugue port"
HOMEPAGE="http://panache.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="gnome-base/gconf
	gnome-base/gnome-vfs
	>=x11-libs/gtk+-2
	media-libs/libart_lgpl
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	dev-libs/libxml2
	net-libs/linc
	gnome-base/ORBit2
	dev-util/pkgconfig"

src_compile() {
	econf
	emake || die "Compilation failed"
}

src_install() {
	einstall
}
