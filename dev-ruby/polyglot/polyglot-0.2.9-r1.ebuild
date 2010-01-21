# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/polyglot/polyglot-0.2.9-r1.ebuild,v 1.5 2010/01/21 11:18:55 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Polyglot provides support for fully-custom DSLs."
HOMEPAGE="http://polyglot.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_test() {
	${RUBY} test/test_polyglot.rb || die "tests failed"
}
