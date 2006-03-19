# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gargoyle/gargoyle-20051002.ebuild,v 1.2 2006/03/19 23:56:32 halcy0n Exp $

DESCRIPTION="A typographically beautiful Glk library"
HOMEPAGE="http://ghostscript.com/~tor/software/gargoyle/"
SRC_URI="http://ghostscript.com/~tor/download/gargoyle/${P}-source.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=media-libs/freetype-2.1.9-r1
	>=x11-libs/gtk+-2.8.8
	>=dev-libs/glib-2.8.5
	>=media-libs/jpeg-6b-r5
	>=media-libs/libpng-1.2.8
	>=sys-libs/zlib-1.2.3
	>=media-libs/fmod-3.74"

DEPEND="${RDEPEND}
	>=dev-util/jam-2.5-r3
	app-arch/unzip"

src_compile()
{
	jam
}

src_install()
{
	dolib bin/libgargoyle.so
	dodoc garglk/Readme.html garglk/TODO
	cd bin
	dobin gargoyle glulxe frotz
}
