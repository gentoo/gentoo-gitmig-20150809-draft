# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/lyntin/lyntin-4.2.ebuild,v 1.2 2009/01/19 23:25:20 mr_bones_ Exp $

EAPI=2
inherit eutils games distutils

DESCRIPTION="tintin mud client clone implemented in Python"
HOMEPAGE="http://lyntin.sourceforge.net/"
SRC_URI="mirror://sourceforge/lyntin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="tk"

DEPEND=">=dev-lang/python-2.2.3[tk?]"

DOCS="COMMANDS PKG-INFO HACKING README"

src_install() {
	distutils_src_install
	dogamesbin "${D}/usr/bin/runlyntin" || die "dogamesbin failed"
	rm -rf "${D}/usr/bin/"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if use tk ; then
		elog "To start lyntin in GUI mode, create a config file"
		elog "with this in it:"
		elog
		elog "[Lyntin]"
		elog "ui:    tk"
		elog
		elog "Then start lyntin like this:"
		elog
		elog "runlyntin -c /path/to/config_file\n"
	fi
}
