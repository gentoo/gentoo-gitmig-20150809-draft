# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/greenhouse/greenhouse-1.0.1.ebuild,v 1.3 2008/05/10 07:46:01 jmglov Exp $

inherit eutils

DESCRIPTION="The Greenhouse is a game store brought together by Penny Arcade and Hothead Games."
HOMEPAGE="http://www.playgreenhouse.com/"
SRC_URI="http://download.playgreenhouse.com/downloaderlinux-${PV}.tar.gz"

LICENSE="Greenhouse"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

# Greenhouse should not be stripped
RESTRICT="strip"
DEPEND=""
RDEPEND="x86? (
		>=dev-libs/glib-2
		media-libs/libpng
		sys-libs/zlib
		>=x11-libs/gtk+-2
		x11-libs/libX11
		x11-libs/libXinerama
		x11-libs/pango
	)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
	)"

src_compile() {
	einfo "Binary package; nothing to compile"
}

src_install() {
	newbin DownloaderLin ${PN}
}
