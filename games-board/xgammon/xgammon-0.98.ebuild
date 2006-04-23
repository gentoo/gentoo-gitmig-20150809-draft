# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xgammon/xgammon-0.98.ebuild,v 1.9 2006/04/23 06:51:49 mr_bones_ Exp $

inherit eutils

DESCRIPTION="very nice backgammon game for X"
HOMEPAGE="http://fawn.unibw-hamburg.de/steuer/xgammon/xgammon.html"
SRC_URI="http://fawn.unibw-hamburg.de/steuer/xgammon/Downloads/${P}a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="|| ( x11-libs/libXaw virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( app-text/rman
			x11-misc/imake )
		virtual/x11 )"

S=${WORKDIR}/${P}a

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}/${P}-broken.patch" \
		"${FILESDIR}/${P}-config.patch" \
		"${FILESDIR}/gcc33.patch"
}

src_compile() {
	xmkmf || die "xmkmf died"
	env PATH="${PATH}:." emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
