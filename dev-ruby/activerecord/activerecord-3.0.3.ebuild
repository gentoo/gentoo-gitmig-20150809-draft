# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord/activerecord-3.0.3.ebuild,v 1.3 2011/01/07 13:19:19 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

# this is not null so that the dependencies will actually be filled
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activerecord.gemspec"

inherit ruby-fakegem

DESCRIPTION="Implements the ActiveRecord pattern (Fowler, PoEAA) for ORM"
HOMEPAGE="http://rubyforge.org/projects/activerecord/"
SRC_URI="http://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="mysql postgres sqlite3" #sqlite

S="${WORKDIR}/rails-rails-*/activerecord"

ruby_add_rdepend "~dev-ruby/activesupport-${PV}
	~dev-ruby/activemodel-${PV}
	>=dev-ruby/arel-2.0.2
	>=dev-ruby/tzinfo-0.3.23
	sqlite3? ( dev-ruby/sqlite3-ruby )
	mysql? ( dev-ruby/mysql2 )
	postgres? ( dev-ruby/pg )"

#ruby_add_rdepend sqlite ">=dev-ruby/sqlite-ruby-2.2.2"

ruby_add_bdepend "
	test? (
		dev-ruby/sqlite3-ruby
		>=dev-ruby/mocha-0.9.5
		virtual/ruby-test-unit
		!dev-ruby/test-unit:2
	)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/cases/helper.rb || die "Unable to remove load paths"
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			;;
		*)
			if use sqlite3; then
				${RUBY} -S rake test_sqlite3 || die "sqlite3 tests failed"
			fi
			;;
	esac
}
