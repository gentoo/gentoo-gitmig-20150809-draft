# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-1.1.1.ebuild,v 1.4 2003/11/29 22:06:22 brad_mssw Exp $

inherit gnome2

DESCRIPTION="Spellchecker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"

SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc amd64"

IUSE=""

# The || is meant to make sure there is a a default spell lib to work with
# 25 Aug 2003; foser <foser@gentoo.org>
RDEPEND=">=dev-libs/glib-2
	|| ( virtual/aspell-dict app-text/ispell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING.LIB ChangeLog HACKING MAINTAINERS NEWS README TODO"
