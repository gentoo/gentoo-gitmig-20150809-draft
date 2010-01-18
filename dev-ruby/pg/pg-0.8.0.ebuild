# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pg/pg-0.8.0.ebuild,v 1.4 2010/01/18 20:54:28 ranger Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

# Tests will always fail because they need access to the pgsql server
RUBY_FAKEGEM_TEST_TASK="spec"
RESTRICT="test"

RUBY_FAKEGEM_DOCDIR="doc/rdoc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog Contributors README"

inherit ruby-fakegem

DESCRIPTION="Ruby extension library providing an API to PostgreSQL"
HOMEPAGE="http://bitbucket.org/ged/ruby-pg/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

RDEPEND="dev-db/postgresql-base"
DEPEND="${RDEPEND}"

all_ruby_prepare() {
	sed -i \
		-e '/ext_helper/s:^:#:' \
		-e '/task :spec =>/s:^:#:' \
		Rakefile || die "Rakefile fix failed"
}

each_ruby_compile() {
	pushd "${S}"/ext
	${RUBY} extconf.rb || die "extconf.rb failed"
	emake || die "emake failed"
	popd
}

each_ruby_install() {
	ruby_fakegem_newins ext/pg.so lib/pg.so
	each_fakegem_install
}

all_ruby_install() {
	docinto examples
	dodoc sample/*.rb || die "sample installation failed"
}
