# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-1.0.0.ebuild,v 1.6 2004/04/07 21:48:46 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="Spellchecker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"
SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha"
IUSE=""

# The || is meant to make sure there is a a default spell lib to work with
# 25 Aug 2003; foser <foser@gentoo.org>
RDEPEND=">=dev-libs/glib-2
	|| ( app-text/aspell app-text/ispell )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING.LIB ChangeLog HACKING MAINTAINERS NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	use alpha && epatch ${FILESDIR}/enchant-1.0.0-alpha.patch
}
