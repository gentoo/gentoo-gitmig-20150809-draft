# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thin/thin-1.2.5-r1.ebuild,v 1.7 2010/08/13 23:38:19 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="A fast and very simple Ruby web server"
HOMEPAGE="http://code.macournoyer.com/thin/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="${DEPEND}
	dev-util/ragel"
RDEPEND="${RDEPEND}"

# The runtime dependencies are used at build-time as well since the
# Rakefile loads thin!
mydeps=">=dev-ruby/daemons-1.0.9
	>=dev-ruby/rack-1.0.0
	>=dev-ruby/eventmachine-0.12.6
	virtual/ruby-ssl"

ruby_add_rdepend "${mydeps}"
ruby_add_bdepend "${mydeps}
	dev-ruby/rake-compiler
	test? ( dev-ruby/rspec )"

all_ruby_prepare() {
	# Fix Ragel-based parser generation (uses a *very* old syntax that
	# is not supported in Gentoo)
	sed -i -e 's: | rlgen-cd::' Rakefile || die

	# Fix specs' dependencies so that the extension is not rebuilt
	# when running tests
	sed -i -e '/:spec =>/s:^:#:' tasks/spec.rake || die

	# Disable a test that is known for freezing the testsuite,
	# reported upstream.
	sed -i \
		-e '/should force kill process in pid file/,/^  end/ s:^:#:' \
		spec/daemonizing_spec.rb || die

	epatch "${FILESDIR}"/${P}-tests.patch

	# nasty but too complex to fix up for now :(
	use test || rm tasks/spec.rake
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "rake compile failed"
}
