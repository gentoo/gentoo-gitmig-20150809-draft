# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/lucidlife/lucidlife-0.9.2.ebuild,v 1.1 2010/11/08 01:32:44 xmw Exp $

EAPI=2

inherit games

DESCRIPTION="A Conway's Life simulator written in GTK+2 - fork from Gtklife"
HOMEPAGE="http://linux.softpedia.com/get/GAMES-ENTERTAINMENT/Simulation/LucidLife-26633.shtml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-base/gnome-vfs
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_install() {
	emake install \
		desktopdir=/usr/share/applications \
		pixmapdir=/usr/share/pixmaps \
		DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die
	prepgamesdirs
}
