# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/htmlentities/htmlentities-4.2.0-r2.ebuild,v 1.2 2009/12/15 18:57:22 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

inherit ruby-fakegem

DESCRIPTION="A simple library for encoding/decoding entities in (X)HTML documents."
HOMEPAGE="http://htmlentities.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_test() {
	${RUBY} -Ilib test/test_all.rb || die "tests failed"
}
