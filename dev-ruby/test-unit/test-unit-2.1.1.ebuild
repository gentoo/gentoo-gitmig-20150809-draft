# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.1.1.ebuild,v 1.1 2010/08/06 13:56:42 flameeyes Exp $

EAPI=2
# One test fails on jruby, might be a jruby bug
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="TODO README.txt History.txt"

# Disable default binwraps
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

ruby_add_bdepend "doc? ( dev-ruby/hoe )"

DESCRIPTION="An improved version of the Test::Unit framework from Ruby 1.8"
HOMEPAGE="http://test-unit.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

each_ruby_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"
	local rubyflags

	[[ $(basename ${RUBY}) == jruby ]] && rubyflags="-X+O"

	${RUBY} ${rubyflags} test/run-test.rb || die "testsuite failed"
}

all_ruby_install() {
	all_fakegem_install

	# Create a testrb2 wrapper similarly to the rdoc2 wrapper for
	# rdoc-2* series.
	ruby_fakegem_binwrapper testrb /usr/bin/testrb-2
}
