# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/teg/teg-0.11.0-r1.ebuild,v 1.6 2004/07/14 14:31:47 agriffis Exp $

inherit games gnome2

DESCRIPTION="Gnome Risk Clone"
HOMEPAGE="http://teg.sourceforge.net/"
SRC_URI="mirror://sourceforge/teg/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="nls readline"

DEPEND="virtual/libc
	virtual/x11
	dev-libs/glib
	gnome-base/libgnomeui
	gnome-base/libgnome
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		$(use_enable nls) \
		--bindir="${GAMES_BINDIR}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make \
		DESTDIR="${D}" install \
		" sScrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ ${1}" \
		|| die "make install failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	prepgamesdirs
}

pkg_postinst() {
	gnome2_gconf_install
}
