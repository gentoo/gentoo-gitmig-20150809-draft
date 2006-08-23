# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gargoyle/gargoyle-20060703.ebuild,v 1.1 2006/08/23 13:11:02 s4t4n Exp $

inherit eutils

MY_PV="2006-07-03"
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}-source/"
DESCRIPTION="Beautified Glk library and interactive fiction multi-interpreter"
HOMEPAGE="http://ccxvii.net/gargoyle/"
SRC_URI="http://ccxvii.net/gargoyle/download/${MY_P}-source.zip"
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

inherit eutils

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/filename-friendliness.patch
}

src_compile()
{
	jam
}

src_install()
{
	dodoc Readme.txt garglk/TODO licenses/*
	insinto /etc; newins garglk/garglk.ini garglk.ini

	#Should to copy garglk/garglk.ini to /etc/, but I don't know the syntax

	cd build/temp.linux.release
	dolib garglk/libgarglk.so
	dobin advsys/gargoyle-advsys agility/gargoyle-agility alan2/gargoyle-alan2
	dobin alan3/gargoyle-alan3 garglk/gargoyle git/gargoyle-git
	dobin hugo/gargoyle-hugo level9/gargoyle-level9 scare/gargoyle-scare
	dobin tads/gargoyle-tadsr frotz/gargoyle-frotz magnetic/gargoyle-magnetic
}
