# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pg/pg-0.12.0-r1.ebuild,v 1.1 2011/12/18 21:13:51 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TEST_TASK=""

RUBY_FAKEGEM_TASK_DOC="apidocs"
RUBY_FAKEGEM_DOCDIR="docs/api"
RUBY_FAKEGEM_EXTRADOC="ChangeLog Contributors.rdoc README.rdoc History.rdoc"

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

ruby_add_bdepend "
	doc? (
		dev-ruby/hoe
		dev-ruby/rake-compiler
		|| ( >=dev-ruby/yard-0.6.1 dev-ruby/rdoc ) )
	test? ( dev-ruby/rspec:2 )"

all_ruby_prepare() {
	# this is required to make rake-compiler a build-time only
	# dependency rather than a runtime one. Without this, bundler will
	# fail to load pg if rake-compiler is not installed as well (which
	# is silly).
	sed -i -e 's|:runtime|:development|' ../metadata || die
}

each_ruby_configure() {
	${RUBY} -C ext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -C ext CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}"
	cp ext/*.so lib || die
}

each_ruby_test() {
	if [[ "${EUID}" -ne "0" ]]; then
		# Make the rspec call explicit, this way we don't have to depend
		# on rake-compiler (nor rubygems) _and_ we don't have to rebuild
		# the whole extension from scratch.
		${RUBY} -Ilib -S rspec -fs spec/*_spec.rb || die "spec failed"
	else
		ewarn "The userpriv feature must be enabled to run tests."
		eerror "Testsuite will not be run."
	fi
}
