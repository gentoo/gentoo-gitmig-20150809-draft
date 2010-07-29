# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mmap/mmap-0.2.6-r1.ebuild,v 1.2 2010/07/29 10:27:29 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="The Mmap class implement memory-mapped file objects"
HOMEPAGE="http://moulon.inra.fr/ruby/mmap.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

# bug 276238
RESTRICT=test

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake || die "emake failed"

	if use doc; then
		emake rdoc || die "rdoc failed"
	fi
}

each_ruby_test() {
	emake test || die "tests failed"
}

each_ruby_install() {
	doruby mmap.so

	dodoc README.en || die
	dohtml mmap.html || die

	if use doc; then
		pushd docs &>/dev/null
		docinto api
		dohtml -r doc || die
		popd &>/dev/null
	fi
}
