# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.8_beta2.ebuild,v 1.9 2004/07/22 04:59:53 lv Exp $

inherit kde eutils gcc


MY_P=${P/_/}
S="${WORKDIR}/${PN}"

DESCRIPTION="A KDE frontend to CD burning and CD ripping tools"
HOMEPAGE="http://arson.sourceforge.net/"
SRC_URI="mirror://sourceforge/arson/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"
IUSE="oggvorbis"

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-sound/bladeenc-0.94.2
	>=app-cdr/cdrtools-1.11.24
	>=media-sound/normalize-0.7.4
	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	>=media-sound/lame-3.92
	>=app-cdr/cdrdao-1.1.5
	>=media-libs/flac-1.1.0"
need-kde 3

#added base_src_unpack() with conditional fix of code allowing compilation with gcc-3.4.0
base_src_unpack() {
	unpack ${A}
	cd ${S}/src/

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		einfo "Compiler used: gcc-3.4.x Applying patch conditionally."
		sed -i "s:(font()):(font):" wizard.cpp
	fi
	cd ${S}
}

src_compile() {
	myconf="$myconf --with-flac `use_with oggvorbis vorbis`"
	kde_src_compile
}
