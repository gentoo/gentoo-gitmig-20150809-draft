# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint/tuxpaint-0.9.13-r1.ebuild,v 1.1 2004/11/24 01:48:43 leonardop Exp $

inherit eutils

DESCRIPTION="Drawing program designed for young children"
HOMEPAGE="http://www.newbreedsoftware.com/tuxpaint/"

DEPEND="media-libs/libpng
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libsdl
	>=media-libs/freetype-2
	media-libs/netpbm
	nls? ( sys-devel/gettext )"

IUSE="gnome kde nls"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
mirror://gentoo/${P}-makefile.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# Sanitize the hack that is its Makefile
	epatch ${DISTDIR}/${P}-makefile.patch
}

src_compile() {
	local myopts=""

	use nls && myopts="${myopts} ENABLE_GETTEXT=1"

	# emake may break things
	make ${myopts} || die
}

src_install () {
	local myopts=""

	use gnome && myopts="${myopts} GNOME_PREFIX=/usr"

	if use kde && which kde-config ; then
		myopts="${myopts} KDE_PREFIX=\
$(kde-config --install apps --expandvars) KDE_ICON_PREFIX=\
$(kde-config --install icon --expandvars)"
	fi

	use nls && myopts="${myopts} ENABLE_GETTEXT=1"

	make DESTDIR=${D} ${myopts} install || die

	rm docs/INSTALL.txt
	dodoc docs/*.txt
}
