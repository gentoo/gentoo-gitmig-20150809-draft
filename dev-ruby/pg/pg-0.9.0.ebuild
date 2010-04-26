# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pg/pg-0.9.0.ebuild,v 1.1 2010/04/26 14:45:04 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TEST_TASK="spec"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="docs/api"
RUBY_FAKEGEM_EXTRADOC="ChangeLog Contributors README"

inherit ruby-fakegem

DESCRIPTION="Ruby extension library providing an API to PostgreSQL"
HOMEPAGE="http://bitbucket.org/ged/ruby-pg/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-db/postgresql-base"
DEPEND="${RDEPEND}
	test? ( dev-db/postgresql-server )"

# For the rakefile (and thus doc generation and testing) to work as
# intended, you need both rake-compiler _and_ the real RubyGems
# package; what is shipped with Ruby 1.9 is not good enough as it
# lacks the packaging tasks for Rake.
ruby_add_bdepend doc "dev-ruby/rake-compiler dev-ruby/rubygems"
ruby_add_bdepend test "dev-ruby/rspec dev-ruby/rake-compiler dev-ruby/rubygems"

each_ruby_configure() {
	pushd ext
	${RUBY} extconf.rb || die "extconf.rb failed"
	popd
}

each_ruby_compile() {
	pushd ext
	emake CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}" || die "emake failed"
	popd
}
