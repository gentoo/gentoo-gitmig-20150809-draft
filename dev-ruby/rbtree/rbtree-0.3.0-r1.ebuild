# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rbtree/rbtree-0.3.0-r1.ebuild,v 1.1 2010/06/29 04:57:47 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="ChangeLog README"

inherit multilib ruby-fakegem

DESCRIPTION="Ruby/RBTree module."
HOMEPAGE="http://www.geocities.co.jp/SiliconValley-PaloAlto/3388/rbtree/README.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

each_ruby_configure() {
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_test() {
	${RUBY} test.rb || die
}

each_ruby_install() {
	mkdir lib || die
	mv rbtree$(get_modname) lib/ || die
	each_fakegem_install
}
