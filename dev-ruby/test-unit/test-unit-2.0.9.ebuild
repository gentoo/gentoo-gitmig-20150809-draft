# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.0.9.ebuild,v 1.2 2010/06/30 06:27:16 fauli Exp $

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
KEYWORDS="~amd64 ~x86"
IUSE=""

# Two tests for jruby currently fail. This has been reported upstream:
# http://rubyforge.org/tracker/index.php?group_id=5650&atid=21856
RUBY_PATCHES=( "${P}-disable-tests.patch" )

each_ruby_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"
	local rubyflags

	[[ $(basename ${RUBY}) == jruby ]] && rubyflags="-X+O"

	${RUBY} ${rubyflags} test/run-test.rb || die "testsuite failed"
}

all_ruby_intall() {
	all_fakegem_install

	# Create a testrb2 wrapper similarly to the rdoc2 wrapper for
	# rdoc-2* series.
	ruby_fakegem_binwrapper testrb /usr/bint/testrb2
}
