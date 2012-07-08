# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn-layout/prawn-layout-0.8.4-r2.ebuild,v 1.4 2012/07/08 16:06:57 jer Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem versionator

DESCRIPTION="An extension to Prawn offering table support, grid layouts and other things"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86-fbsd"
IUSE="examples"

ruby_add_bdepend test "dev-ruby/test-spec dev-ruby/mocha"

ruby_add_rdepend "=dev-ruby/prawn-core-$(get_version_component_range 1-2)*"

USE_RUBY=ruby19 ruby_add_bdepend "test? ( dev-ruby/test-unit:0 )"

all_ruby_prepare() {
	sed -i -e '6irequire "prawn/core"; ruby_19 { gem "test-unit", "=1.2.3" }' spec/spec_helper.rb || die
}

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
