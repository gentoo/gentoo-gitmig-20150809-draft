# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-termios/ruby-termios-0.9.4.ebuild,v 1.2 2003/05/30 22:26:00 twp Exp $

DESCRIPTION="A Ruby interface to termios"
HOMEPAGE="http://arika.org/ruby/termios/"
SRC_URI="http://arika.org/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
DEPEND=">=dev-lang/ruby-1.6"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README termios.rd
	docinto examples
	dodoc examples/*
}
