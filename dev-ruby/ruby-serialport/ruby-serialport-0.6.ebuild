# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-serialport/ruby-serialport-0.6.ebuild,v 1.8 2006/10/20 21:28:11 agriffis Exp $

inherit ruby

DESCRIPTION="a library for serial port (rs232) access in ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-serialport/"
SRC_URI="http://rubyforge.org/download.php/72/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64 ~ppc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGELOG README
	docinto test
	dodoc test/*
}
