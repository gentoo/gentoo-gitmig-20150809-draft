# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sigar/sigar-0.7.2.ebuild,v 1.1 2012/04/21 07:14:15 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README"

inherit multilib ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://sigar.hyperic.com/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cbindings/ruby extconf.rb || die
}

each_ruby_compile() {
	emake -Cbindings/ruby
}

each_ruby_test() {
	${RUBY} -S testrb bindings/ruby/test/*_test.rb || die
}

each_ruby_install() {
	mkdir lib || die
	cp bindings/ruby/${PN}$(get_modname) lib/ || die

	each_fakegem_install
}
