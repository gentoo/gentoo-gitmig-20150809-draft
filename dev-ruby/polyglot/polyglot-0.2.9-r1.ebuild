# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/polyglot/polyglot-0.2.9-r1.ebuild,v 1.1 2009/12/16 18:39:53 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Polyglot provides support for fully-custom DSLs."
HOMEPAGE="http://polyglot.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_test() {
	${RUBY} test/test_polyglot.rb
}

all_ruby_install() {
	dodoc History.txt README.txt
}
