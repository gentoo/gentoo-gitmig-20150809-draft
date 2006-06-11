# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.6-r1.ebuild,v 1.2 2006/06/11 12:48:04 nelchael Exp $

inherit eutils

DESCRIPTION="Gesture/Handwriting recognition engine for X"
# Dead upstream?
#HOMEPAGE="http://www.xstroke.org/"
HOMEPAGE="http://freshmeat.net/projects/xstroke/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha hppa ~mips ppc sparc x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXtst
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXrender
		x11-libs/libXt
		x11-libs/libXft )
	virtual/x11 )"
DEPEND="${RDEPEND}
	media-libs/freetype
	media-libs/fontconfig
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto )
	virtual/x11 )"

src_unpack() {

	unpack "${A}"
	epatch "${FILESDIR}/${P}-sigsegv_sprintf.patch"

}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
