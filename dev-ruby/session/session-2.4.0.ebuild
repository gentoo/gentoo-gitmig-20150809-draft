# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/session/session-2.4.0.ebuild,v 1.2 2010/01/11 17:58:07 graaff Exp $

EAPI=2

# jruby → “fork is unsafe and disabled by default on JRuby“
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="HISTORY README TODO"

inherit ruby-fakegem

DESCRIPTION="A set of classes to drive external programs via pipe"
HOMEPAGE="http://codeforpeople.com/lib/ruby/session/"
SRC_URI="http://codeforpeople.com/lib/ruby/session/${P}.tgz"

# License info based on http://github.com/ahoward/session as indicated
# by author.
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend test virtual/ruby-test-unit

all_ruby_prepare() {
	# needed to void a collision with the Timeout::Error alias in Ruby
	# 1.8.7 at least.
	sed -i -e 's:TimeoutError:SessionTimeoutError:' test/session.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib test/*.rb || die "tests failed"
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc sample/* || die
}
