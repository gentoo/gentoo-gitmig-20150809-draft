# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-spec/test-spec-0.10.0-r3.ebuild,v 1.2 2011/10/28 15:49:17 jer Exp $

EAPI="2"

# ruby19 → incompatible with test-unit so fails badly
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_EXTRADOC="README SPECS ROADMAP TODO"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem eutils

DESCRIPTION="A library to do Behavior Driven Development with Test::Unit"
HOMEPAGE="http://chneukirchen.org/blog/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_rdepend virtual/ruby-test-unit
ruby_add_bdepend test dev-ruby/mocha

# On Ruby 1.9, the tests only work with test-unit-2, but generally
# speaking, test-spec should work fine with test-unit-1.2.3, and
# indeed some testsuites only work with that.
USE_RUBY=ruby19 \
	ruby_add_bdepend "ruby_targets_ruby19 test" '>=dev-ruby/test-unit-2.0.6'

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-jruby.patch
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
