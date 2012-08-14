# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/unf/unf-0.0.5.ebuild,v 1.2 2012/08/14 16:58:13 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A wrapper library to bring Unicode Normalization Form support to Ruby/JRuby."
HOMEPAGE="https://github.com/knu/ruby-unf"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# jruby already has support for UNF so it does not need the extension.
USE_RUBY=${USE_RUBY/jruby/} ruby_add_rdepend "dev-ruby/unf_ext"

ruby_add_bdepend "
	test? (
		>=dev-ruby/test-unit-2.5.1-r1
		dev-ruby/shoulda
	)"

all_ruby_prepare() {
	sed -i -e '/bundler/,/end/ s:^:#:' test/helper.rb || die
}

each_ruby_test() {
	ruby-ng_testrb-2 test/test_*.rb
}
