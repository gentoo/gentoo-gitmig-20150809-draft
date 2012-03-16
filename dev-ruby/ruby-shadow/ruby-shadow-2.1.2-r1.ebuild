# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shadow/ruby-shadow-2.1.2-r1.ebuild,v 1.1 2012/03/16 00:09:15 matsuu Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="HISTORY README README.euc"

inherit ruby-fakegem

DESCRIPTION="ruby shadow bindings"
HOMEPAGE="http://ttsky.net"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RUBY_PATCHES="${FILESDIR}/${P}-file_ptr.patch"

each_ruby_configure() {
	${RUBY} extconf.rb || die "Configuration failed."
	sed -i -e "/^ldflags  =/s/$/ \$(LDFLAGS)/" Makefile || die
}

each_ruby_compile() {
	emake || die "Compilation failed."
	mkdir lib
	cp shadow.so lib
}
