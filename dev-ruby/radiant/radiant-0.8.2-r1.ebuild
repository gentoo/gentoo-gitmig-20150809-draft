# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radiant/radiant-0.8.2-r1.ebuild,v 1.1 2010/06/01 07:59:44 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec cucumber"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG CONTRIBUTORS README"
RUBY_FAKEGEM_EXTRAINSTALL="app config db public script vendor"

inherit ruby-fakegem

DESCRIPTION="A no-fluff, open source content management system"
HOMEPAGE="http://radiantcms.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_PATCHES=( "${P}-migration.patch" )

# Testing depends on a working database but creating this currently
# fails. This may be breakage related to Rails 2.3.8. Further
# investigation needed.
RESTRICT="test"

#ruby_add_bdepend "test? ( dev-db/sqlite3-ruby  dev-ruby/rspec dev-util/cucumber )"

ruby_add_rdepend ">=dev-ruby/redcloth-4.0.0
	>=dev-ruby/rack-1.0.0
	=dev-ruby/rails-2.3*
	>=dev-ruby/highline-1.5.1
	>=dev-ruby/radius-0.5.1"

# Remove code from vendor that we support as an external dependency.
all_ruby_prepare() {
	rm -rf vendor/{highline,radius,rails,redcloth} || die "Unable to remove vendored code."
}

#each_ruby_test() {
#	cp config/database.sqlite.yml config/database.yml || die "Unable to provide database.yml for testing."
#	${RUBY} -S rake db:migrate
#	each_fakegem_test
#	rm config/database.yml || die "Unable to remove testing database.yml."
#}
