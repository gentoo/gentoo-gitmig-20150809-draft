# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dbd-pg/dbd-pg-0.3.9.ebuild,v 1.5 2012/08/21 16:37:49 johu Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="The PostgreSQL database driver (DBD) for Ruby/DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="mirror://rubyforge/ruby-dbi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

ruby_add_rdepend "
	>=dev-ruby/ruby-dbi-0.4.2
	dev-ruby/pg"

src_test() {
	elog "The tests require additional configuration."
	elog "You will find them in /usr/share/${PN}/test/"
	elog "Be sure to read the file called DBD_TESTS."
}

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr || die
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}" || die "setup.rb install failed"
}

all_ruby_install() {
	if use test; then
		dodir /usr/share/${PN}
		cp -pPR test "${D}/usr/share/${PN}" || die "couldn't copy tests"
	fi
}
