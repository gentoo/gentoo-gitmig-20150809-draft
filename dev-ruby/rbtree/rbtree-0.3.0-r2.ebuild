# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rbtree/rbtree-0.3.0-r2.ebuild,v 1.1 2011/06/15 17:41:25 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="ChangeLog README"

inherit multilib ruby-fakegem

RUBY_FAKEGEM_EXTRAINSTALL="rbtree$(get_modname)"

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
