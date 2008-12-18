# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.8.ebuild,v 1.7 2008/12/18 22:01:50 loki_val Exp $

inherit base eutils kde-functions autotools

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.com/"
SRC_URI="http://www.kmuddy.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="arts sdl"

DEPEND="arts? ( kde-base/arts )
	sdl? ( media-libs/sdl-mixer )"

need-kde 3
PATCHES=(	"${FILESDIR}/${P}-nocrash.patch"
		"${FILESDIR}/${P}-gcc43.patch"
		"${FILESDIR}/${P}-idle-crash.patch"
		"${FILESDIR}/${P}-libtool.patch"
	)

src_unpack() {
	base_src_unpack
	cd "${S}"
	mv admin/acinclude.m4.in acinclude.m4
	eautoreconf
	find . -name Makefile.in -exec perl admin/am_edit ';'
}

src_compile() {
	econf \
		$(use_with arts) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGELOG DESIGN README README.MIDI Scripting-HOWTO TODO
}
