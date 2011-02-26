# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pg/pg-0.9.0-r1.ebuild,v 1.9 2011/02/26 07:49:12 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TEST_TASK=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="docs/api"
RUBY_FAKEGEM_EXTRADOC="ChangeLog Contributors README"

inherit ruby-fakegem

DESCRIPTION="Ruby extension library providing an API to PostgreSQL"
HOMEPAGE="http://bitbucket.org/ged/ruby-pg/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="${RDEPEND}
	dev-db/postgresql-base"
DEPEND="${DEPEND}
	dev-db/postgresql-base
	test? ( dev-db/postgresql-server )"

# For the rakefile (and thus doc generation and testing) to work as
# intended, you need both rake-compiler _and_ the real RubyGems
# package; what is shipped with Ruby 1.9 is not good enough as it
# lacks the packaging tasks for Rake.
ruby_add_bdepend "
	doc? (
		dev-ruby/rake-compiler
		dev-ruby/rubygems )
	test? ( dev-ruby/rspec:0 )"

each_ruby_configure() {
	pushd ext
	${RUBY} extconf.rb || die "extconf.rb failed"
	popd
}

each_ruby_compile() {
	pushd ext
	emake CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}" || die "emake failed"
	popd
	cp ext/*.so lib || die
}

each_ruby_test() {
	# Make the rspec call explicit, this way we don't have to depend
	# on rake-compiler (nor rubygems) _and_ we don't have to rebuild
	# the whole extension from scratch.
	${RUBY} -Ilib -S spec -Du -fs spec/*_spec.rb || die "spec failed"
}
