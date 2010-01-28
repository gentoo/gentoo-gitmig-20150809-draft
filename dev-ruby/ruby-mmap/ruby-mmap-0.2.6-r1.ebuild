# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mmap/ruby-mmap-0.2.6-r1.ebuild,v 1.1 2010/01/28 12:39:29 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

inherit ruby-ng

MY_P=${P/ruby-/}

DESCRIPTION="The Mmap class implement memory-mapped file objects"
HOMEPAGE="http://moulon.inra.fr/ruby/mmap.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

S=${WORKDIR}/${MY_P}


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
