# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-termios/ruby-termios-0.9.4.ebuild,v 1.5 2004/04/10 15:58:59 usata Exp $

inherit ruby

DESCRIPTION="A Ruby interface to termios"
HOMEPAGE="http://arika.org/ruby/termios"	# trailing / isn't needed
SRC_URI="http://arika.org/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~sparc x86"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby"

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
