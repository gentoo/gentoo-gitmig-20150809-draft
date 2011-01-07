# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-2.3.10.ebuild,v 1.2 2011/01/07 09:29:23 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

# The default test task tries to test activerecord with SQLite as well.
RUBY_FAKEGEM_TASK_TEST="test_action_pack"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

#RUBY_PATCHES=( "${P}-custom-cookie-fix.patch" )

ruby_add_rdepend "~dev-ruby/activesupport-${PV}
	>=dev-ruby/rack-1.1.0"

ruby_add_bdepend "
	test? (
		dev-ruby/activerecord:${SLOT}
		dev-ruby/actionmailer:${SLOT}
		!dev-ruby/test-unit:2
	)"

all_ruby_prepare() {
	# Custom template not found in package
	sed -i -e '/horo/d' Rakefile || die

	# This tries to load a “vendorized” copy of activerecord that we
	# will never have. It can now also use a normally installed
	# version but these tests fail.
	sed -i -e '/PATH_TO_AR/s:^:#:' -e 's/self.able_to_connect = true/self.able_to_connect = false/' test/active_record_unit.rb || die

	# Fix the testsuite, the symlink is not present in the gem for
	# some reason
	ln -s ../../symlink_parent test/fixtures/layout_tests/layouts/symlinked

	# MemCacheStore tests no longer fail gracefully, and it's unlikely for
	# someone to have them running anyway, so remove them for now.
	rm test/controller/session/mem_cache_store_test.rb || die
}
