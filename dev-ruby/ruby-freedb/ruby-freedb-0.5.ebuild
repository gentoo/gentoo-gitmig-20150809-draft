# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-freedb/ruby-freedb-0.5.ebuild,v 1.4 2004/04/10 15:23:13 usata Exp $

inherit ruby

DESCRIPTION="A Ruby library to access cddb/freedb servers"
HOMEPAGE="http://ruby-freedb.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/69/${P}.tar.gz"
LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="alpha ~hppa ~mips ~sparc x86"
USE_RUBY="ruby16 ruby18 ruby19"
IUSE=""
DEPEND="virtual/ruby"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGELOG README
	dohtml -r doc/*
}
