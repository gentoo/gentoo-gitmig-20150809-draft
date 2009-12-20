# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.0.5.ebuild,v 1.3 2009/12/20 22:28:28 flameeyes Exp $

EAPI=2
# One test fails on jruby, might be a jruby bug
# When enabled on ruby18 it breaks too many things, so don't enable it for that just yet
USE_RUBY="ruby19"

# Don't enable docs yet since this requires hoe
RUBY_FAKEGEM_TASK_DOC="" # doc
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="TODO README.txt History.txt"

inherit ruby-fakegem

#ruby_add_bdepend doc dev-ruby/hoe

DESCRIPTION="An improved version of the Test::Unit framework from Ruby 1.8"
HOMEPAGE="http://test-unit.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

each_ruby_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"
	local rubyflags

	[[ $(basename ${RUBY}) == jruby ]] && rubyflags="-X+O"

	${RUBY} ${rubyflags} test/run-test.rb || die "testsuite failed"
}
