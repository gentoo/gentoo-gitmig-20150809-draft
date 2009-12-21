# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/syntax/syntax-1.0.0-r1.ebuild,v 1.1 2009/12/21 00:07:00 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

# Seem to get stuck, somebody should look into it, most likely.
RESTRICT=test

inherit ruby-fakegem

DESCRIPTION="Syntax highlighting for sourcecode and HTML"
HOMEPAGE="http://syntax.rubyforge.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_test() {
	${RUBY} -Ilib test/ALL-TESTS.rb || die "tests failed"
}
