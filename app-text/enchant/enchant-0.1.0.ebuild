# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-0.1.0.ebuild,v 1.1 2003/07/28 17:44:46 foser Exp $

inherit gnome2

DESCRIPTION="Spell checker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"

SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

# enchant doesn't need a spell lib around to build or 'work'
# the aspell dep is meant to provide a sensible working default
#
# foser <foser@gentoo.org>

RDEPEND=">=dev-libs/glib-2
	app-text/aspell"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
