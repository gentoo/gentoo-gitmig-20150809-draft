# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-0.6.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

DESCRIPTION="An improved version of MUDix, a MUD client for the Linux console.  It is designed to run as an X application, and was developed with GTK+ 2.0.  gMUDix has all the features of MUDix and more, including ANSI color mapping, aliasing, macros, paths, tab completions, timers, triggers, variables, and an easy-to-use script language."
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=gtk+-2.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr --sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die
}

src_install() {
	dobin src/gmudix
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO doc/*
}
