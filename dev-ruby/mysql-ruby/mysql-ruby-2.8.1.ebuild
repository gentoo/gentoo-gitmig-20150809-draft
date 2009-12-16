# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mysql-ruby/mysql-ruby-2.8.1.ebuild,v 1.4 2009/12/16 19:15:58 jer Exp $

inherit ruby

DESCRIPTION="A Ruby extension library to use MySQL"
HOMEPAGE="http://www.tmtm.org/en/mysql/ruby/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="virtual/ruby
	virtual/mysql"
RDEPEND="${DEPEND}"

TEST_DIR="/usr/share/${PN}/test/"

src_unpack() {
	unpack ${A}
	if use hppa; then
		sed -e 's/LONG_LONG/long long/' -i "${S}"/mysql.c.in
	fi

	epatch "${FILESDIR}/${P}-test.patch"
}

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dohtml *

	insinto $TEST_DIR
	doins test.rb
}

src_test() {
	elog
	elog "To test the library you need to start MySQL first."
	elog "Then run:"
	elog
	elog "	% ruby ${TEST_DIR}test.rb <hostname> <user> <password>"
	elog
	elog "See /usr/share/doc/${PF}/html/README.html for details."
	elog
}
