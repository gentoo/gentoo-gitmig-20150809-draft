# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dep_selector/dep_selector-0.0.8.ebuild,v 1.2 2011/08/06 14:01:54 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="constraint based package dependency resolver"
HOMEPAGE="https://github.com/algorist/dep_selector"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND} >=dev-libs/gecode-3.5.0"
RDEPEND="${RDEPEND} >=dev-libs/gecode-3.5.0"

each_ruby_configure() {
	${RUBY} -Cext/dep_gecode extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext/dep_gecode CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}" || die "make extension failed"
	cp ext/dep_gecode/dep_gecode$(get_modname) lib/ || die
	cp ext/dep_gecode/lib/dep_selector_to_gecode.rb lib/ || die
}
