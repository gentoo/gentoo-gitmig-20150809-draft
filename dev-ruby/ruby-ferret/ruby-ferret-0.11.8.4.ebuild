# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-ferret/ruby-ferret-0.11.8.4.ebuild,v 1.1 2012/04/16 05:53:25 graaff Exp $

EAPI=2

# ruby19 fails tests
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_NAME="ferret"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc/api"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG RELEASE_CHANGES RELEASE_NOTES README TODO TUTORIAL"

inherit multilib ruby-fakegem

MY_P="${P/ruby-/}"
DESCRIPTION="A ruby indexing/searching library"
HOMEPAGE="http://ferret.davebalmain.com/trac/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die
}

each_ruby_compile() {
	emake -Cext || die
}

each_ruby_test() {
	${RUBY} -Iext:lib test/test_all.rb || die
}

each_ruby_install() {
	mv ext/ferret_ext$(get_modname) lib/ || die
	each_fakegem_install
}
