# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dbd-pg/dbd-pg-0.3.8.ebuild,v 1.5 2010/08/20 08:03:57 fauli Exp $

inherit "ruby"

DESCRIPTION="The PostgreSQL database driver (DBD) for Ruby/DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="mirror://rubyforge/ruby-dbi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE="test"

RDEPEND="
	>=dev-ruby/ruby-dbi-0.4.2
	>=dev-ruby/ruby-postgres-0.7.9.20080128"

# ruby-postgres is not yet ruby19
USE_RUBY="ruby18"

src_test() {
	elog "The tests require additional configuration."
	elog "You will find them in /usr/share/${PN}/test/"
	elog "Be sure to read the file called DBD_TESTS."
}

src_install() {
	ruby setup.rb install \
		--prefix="${D}" || die "setup.rb install failed"

	if use test; then
		dodir /usr/share/${PN}
		cp -pPR test "${D}/usr/share/${PN}" || die "couldn't copy tests"
	fi
}
