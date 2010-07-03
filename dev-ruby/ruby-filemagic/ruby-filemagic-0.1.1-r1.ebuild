# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-filemagic/ruby-filemagic-0.1.1-r1.ebuild,v 1.1 2010/07/03 10:11:12 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="Ruby binding to libmagic"
HOMEPAGE="http://grub.ath.cx/filemagic/"
SRC_URI="http://grub.ath.cx/filemagic/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

# Tests are broken because newer file implemenations provide more
# information than the tests expect.
RESTRICT="test"
#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

DEPEND="${DEPEND} sys-apps/file"
RDEPEND="${RDEPEND} sys-apps/file"

each_ruby_configure() {
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_test() {
	${RUBY} -Ctest regress.rb || die
}

each_ruby_install() {
	DESTDIR="${D}" emake install || die
}

all_ruby_install() {
	dodoc CHANGELOG README TODO filemagic.rd || die
}
