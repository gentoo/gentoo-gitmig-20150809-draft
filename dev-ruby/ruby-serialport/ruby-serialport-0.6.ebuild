# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-serialport/ruby-serialport-0.6.ebuild,v 1.9 2009/02/08 19:55:33 a3li Exp $

inherit ruby

DESCRIPTION="a library for serial port (rs232) access in ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-serialport/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64 ~ppc x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND="=dev-lang/ruby-1.8*"
RDEPEND="${DEPEND}"

src_compile() {
	ruby18 extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGELOG README
	docinto test
	dodoc test/*
}
