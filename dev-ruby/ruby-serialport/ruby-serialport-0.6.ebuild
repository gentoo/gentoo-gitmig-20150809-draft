# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-serialport/ruby-serialport-0.6.ebuild,v 1.2 2004/04/10 16:07:08 usata Exp $

inherit ruby

DESCRIPTION="a library for serial port (rs232) access in ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-serialport/"
SRC_URI="http://rubyforge.org/download.php/72/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGELOG README
	docinto test
	dodoc test/*
}
