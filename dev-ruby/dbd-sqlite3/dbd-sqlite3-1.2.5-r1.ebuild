# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dbd-sqlite3/dbd-sqlite3-1.2.5-r1.ebuild,v 1.2 2011/02/12 16:09:03 xarthisius Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="The SQLite 3 database driver (DBD) for Ruby/DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="mirror://rubyforge/ruby-dbi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

ruby_add_rdepend "
	>=dev-ruby/ruby-dbi-0.4.2
	>=dev-ruby/sqlite3-ruby-1.2.4"

src_test() {
	elog "The tests require additional configuration."
	elog "You will find them in /usr/share/${PN}/test/"
	elog "Be sure to read the file called DBD_TESTS."
}

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr || die
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}" || die "setup.rb install failed"
}

all_ruby_install() {
	if use test; then
		dodir /usr/share/${PN}
		cp -pPR test "${D}/usr/share/${PN}" || die "couldn't copy tests"
	fi
}
