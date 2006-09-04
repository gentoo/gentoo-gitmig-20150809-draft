# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mysql-ruby/mysql-ruby-2.7.ebuild,v 1.10 2006/09/04 01:19:02 kumba Exp $

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
	>=dev-db/mysql-3.23.58"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dohtml *
}

src_test() {
	einfo
	einfo "To test the programme you need to start mysql first."
	einfo "Then extract the tarball and run"
	einfo
	einfo "	% ruby test.rb hostname user password"
	einfo
	einfo "See /usr/share/doc/${PF}/html/README.html for detail."
	einfo
}
