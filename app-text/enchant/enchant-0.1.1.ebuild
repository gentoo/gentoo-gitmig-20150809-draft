# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-0.1.1.ebuild,v 1.2 2003/08/22 01:40:11 lu_zero Exp $

inherit gnome2

DESCRIPTION="Spellchecker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"

SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

# enchant doesn't need a spell lib around to build or 'work'
# the aspell dep is meant to provide a sensible working default
#
# foser <foser@gentoo.org>

RDEPEND=">=dev-libs/glib-2
	app-text/aspell"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING.LIB ChangeLog HACKING MAINTAINERS NEWS README TODO"
