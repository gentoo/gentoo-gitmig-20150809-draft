# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-freedb/ruby-freedb-0.5.ebuild,v 1.16 2009/12/20 14:12:36 graaff Exp $

RUBY_BUG_145222=yes
inherit ruby

DESCRIPTION="A Ruby library to access cddb/freedb servers"
HOMEPAGE="http://ruby-freedb.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/69/${P}.tar.gz"
LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ~sparc x86"
USE_RUBY="ruby18"
IUSE="examples"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGELOG README
	dohtml -r doc/*
}
