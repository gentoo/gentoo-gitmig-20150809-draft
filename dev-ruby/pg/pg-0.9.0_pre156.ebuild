# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pg/pg-0.9.0_pre156.ebuild,v 1.1 2010/02/19 09:30:14 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

# Tests will always fail because they need access to the pgsql server
RUBY_FAKEGEM_TEST_TASK="spec"
RESTRICT="test"

# Disable documentation generation, until upstream problems with the
# build system are fixed, see:
# http://bitbucket.org/ged/ruby-pg/issue/15/080-gem-has-broken-rakefile
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc/rdoc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog Contributors README"

inherit ruby-fakegem

DESCRIPTION="Ruby extension library providing an API to PostgreSQL"
HOMEPAGE="http://bitbucket.org/ged/ruby-pg/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-db/postgresql-base"
DEPEND="${RDEPEND}"

each_ruby_compile() {
	pushd "${S}"/ext
	${RUBY} extconf.rb || die "extconf.rb failed"
	emake || die "emake failed"
	popd
}

each_ruby_install() {
	ruby_fakegem_newins ext/pg_ext.so lib/pg_ext.so
	each_fakegem_install
}
