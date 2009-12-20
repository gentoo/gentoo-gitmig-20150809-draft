# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-spec/test-spec-0.10.0-r2.ebuild,v 1.3 2009/12/20 22:33:56 flameeyes Exp $

EAPI="2"

# ruby19 → incompatible with test-unit so fails badly
# jruby → fails tests because IO.path method is missing
USE_RUBY="ruby18"

RUBY_FAKEGEM_EXTRADOC="README SPECS ROADMAP TODO"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem eutils

DESCRIPTION="A library to do Behavior Driven Development with Test::Unit"
HOMEPAGE="http://chneukirchen.org/blog/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend virtual/ruby-test-unit
ruby_add_bdepend test dev-ruby/mocha

all_ruby_install() {
	all_fakegem_install

	ruby_fakegem_binwrapper specrb

	if use doc; then
		dodoc examples/* || die
	fi
}
