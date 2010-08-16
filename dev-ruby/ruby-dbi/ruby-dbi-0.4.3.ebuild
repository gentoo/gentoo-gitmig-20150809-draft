# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.4.3.ebuild,v 1.2 2010/08/16 23:16:03 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

MY_P=${P##ruby-}

DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="mirror://rubyforge/ruby-dbi/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="examples odbc postgres mysql sqlite sqlite3 test"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
ruby_add_rdepend "dev-ruby/deprecated"

PDEPEND="
	mysql?    ( dev-ruby/dbd-mysql )
	postgres? ( dev-ruby/dbd-pg )
	odbc?     ( dev-ruby/dbd-odbc )
	sqlite?   ( dev-ruby/dbd-sqlite )
	sqlite3?  ( dev-ruby/dbd-sqlite3 )"

S="${WORKDIR}/${MY_P}"

RUBY_PATCHES=( "${FILESDIR}/${P}-drivers-test.patch" )

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr
}

each_ruby_test() {
	${RUBY} test/ts_dbi.rb || die "Tests failed."
}

each_ruby_install() {
	${RUBY} setup.rb install \
		--prefix="${D}" || die "setup.rb install failed"
}

all_ruby_install() {
	dodoc ChangeLog README

	if use examples ; then
		cp -pPR examples "${D}/usr/share/doc/${PF}" || die "cp examples failed"
	fi
}

pkg_postinst() {
	if ! (use mysql || use postgres || use odbc || use sqlite || use sqlite3)
	then
		elog "${P} now comes with external database drivers."
		elog "Be sure to set the right USE flags for ${PN} or emerge the drivers manually:"
		elog "They are called dev-ruby/dbd-{mysql,odbc,pg,sqlite,sqlite3}"
	fi
}
