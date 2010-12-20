# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/lucidlife/lucidlife-0.9.2.ebuild,v 1.4 2010/12/20 12:24:54 hwoarang Exp $

EAPI=2

inherit autotools eutils games

DESCRIPTION="A Conway's Life simulator written in GTK+2 - fork from Gtklife"
HOMEPAGE="http://linux.softpedia.com/get/GAMES-ENTERTAINMENT/Simulation/LucidLife-26633.shtml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gnome-vfs.patch
	eautoreconf
	intltoolize --force --copy --automake || die
}

src_install() {
	emake install \
		desktopdir=/usr/share/applications \
		pixmapdir=/usr/share/pixmaps \
		DESTDIR="${D}" || die "install failed"

	prepgamesdirs

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
