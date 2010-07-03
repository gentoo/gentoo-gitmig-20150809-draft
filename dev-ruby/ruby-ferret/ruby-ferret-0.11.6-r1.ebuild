# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-ferret/ruby-ferret-0.11.6-r1.ebuild,v 1.1 2010/07/03 08:32:11 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME="ferret"

RUBY_FAKEGEM_TASK_DOC="appdoc"
RUBY_FAKEGEM_DOCDIR="doc/api"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO TUTORIAL"

inherit multilib ruby-fakegem

MY_P="${P/ruby-/}"
DESCRIPTION="A ruby indexing/searching library"
HOMEPAGE="http://ferret.davebalmain.com/trac/"
LICENSE="Ruby"
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
