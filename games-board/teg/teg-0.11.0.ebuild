# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/teg/teg-0.11.0.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Risk Clone"
SRC_URI="mirror://sourceforge/teg/${P}.tar.bz2"
HOMEPAGE="http://teg.sourceforge.net"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	virtual/x11
	dev-libs/glib
	gnome-base/libgnomeui
	gnome-base/libgnome"

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die
}

src_install() {
#	make DESTDIR=${D} install || die
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	egamesinstall " sScrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ ${1}"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
#	egamesinstall
	prepgamesdirs
}

pkg_postinst() {
	gnome2_gconf_install
}
