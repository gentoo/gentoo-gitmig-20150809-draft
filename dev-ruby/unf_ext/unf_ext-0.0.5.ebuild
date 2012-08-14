# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/unf_ext/unf_ext-0.0.5.ebuild,v 1.2 2012/08/14 16:57:17 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem multilib

DESCRIPTION="Unicode Normalization Form support library for CRuby"
HOMEPAGE="http://sourceforge.jp/projects/unf/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

ruby_add_bdepend "doc? ( dev-ruby/hoe dev-ruby/jeweler )
	test? (
		>=dev-ruby/test-unit-2.5.1-r1
		dev-ruby/shoulda
	)"

all_ruby_prepare() {
	sed -i -e '/bundler/,/end/ s:^:#:' Rakefile test/helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/unf_ext extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/unf_ext CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}"
	cp ext/unf_ext/*$(get_modname) lib/ || die
}

each_ruby_test() {
	ruby-ng_testrb-2 test/test_*.rb
}
