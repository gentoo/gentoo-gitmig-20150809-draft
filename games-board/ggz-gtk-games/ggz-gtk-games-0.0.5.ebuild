# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-games/ggz-gtk-games-0.0.5.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

DESCRIPTION="These are the gtk versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="=app-games/ggz-gtk-client-0.0.5"

src_compile() {
	econf
	# we need to remove some /usr-paths that ggz-config puts into in 
	# the makefile.  ugly.  :/

	sed -e "s|^ggzdatadir = /|ggzdatadir = ${D}|" Makefile > Makefile.new
	sed -e "s|^ggzexecmoddir = /|ggzexecmoddir = ${D}|" Makefile.new > Makefile

	emake || die
}

src_install() {
	insinto /etc
	doins /etc/ggz.modules

	make DESTDIR=${D} install || die
}
