# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-1.1.3.ebuild,v 1.16 2007/01/05 07:26:12 flameeyes Exp $

inherit gnome2

DESCRIPTION="Spellchecker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"
SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""
# FIXME : some sort of proper spellchecker selection needed

# The || is meant to make sure there is a a default spell lib to work with
# 25 Aug 2003; foser <foser@gentoo.org>

RDEPEND=">=dev-libs/glib-2
	|| ( virtual/aspell-dict app-text/ispell app-text/hspell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS ChangeLog HACKING MAINTAINERS NEWS README TODO"
