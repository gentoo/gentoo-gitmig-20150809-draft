# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/lyntin/lyntin-4.1.1.ebuild,v 1.5 2005/06/15 18:54:40 wolf31o2 Exp $

inherit games distutils

DESCRIPTION="tintin mud client clone implemented in Python"
HOMEPAGE="http://lyntin.sourceforge.net/"
SRC_URI="mirror://sourceforge/lyntin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="tcltk"

DEPEND=">=dev-lang/python-2.2.3"

DOCS="COMMANDS PKG-INFO HACKING README"

pkg_setup() {
	if ! built_with_use dev-lang/python tcltk ; then
		eerror "You need to recompile python with Tkinter support."
		eerror "Example: USE='X -build tcltk' emerge python"
		echo
		die "missing tkinter support with installed python"
	fi
	games_pkg_setup
}

src_install() {
	distutils_src_install
	dogamesbin "${D}/usr/bin/runlyntin" || die "dogamesbin failed"
	rm -rf "${D}/usr/bin/"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if use tcltk ; then
		einfo "To start lyntin in GUI mode, create a config file"
		einfo "with this in it:"
		echo
		einfo "[Lyntin]"
		einfo "ui:    tk"
		echo
		einfo "Then start lyntin like this:"
		einfo " "
		einfo "runlyntin -c /path/to/config_file\n"
	fi
}
