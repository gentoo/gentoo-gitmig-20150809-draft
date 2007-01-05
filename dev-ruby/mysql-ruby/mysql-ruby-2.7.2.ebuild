# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mysql-ruby/mysql-ruby-2.7.2.ebuild,v 1.2 2007/01/05 16:48:20 flameeyes Exp $

inherit ruby

DESCRIPTION="A Ruby extension library to use MySQL"
HOMEPAGE="http://www.tmtm.org/en/mysql/ruby/"
SRC_URI="http://www.tmtm.org/downloads/mysql/ruby/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""

USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby
	virtual/mysql"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dohtml *
}

src_test() {
	elog
	elog "To test the programme you need to start mysql first."
	elog "Then extract the tarball and run"
	elog
	elog "	% ruby test.rb hostname user password"
	elog
	elog "See /usr/share/doc/${PF}/html/README.html for detail."
	elog
}
