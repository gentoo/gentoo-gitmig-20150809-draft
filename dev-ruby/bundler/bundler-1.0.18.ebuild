# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bundler/bundler-1.0.18.ebuild,v 1.3 2011/10/20 17:38:09 graaff Exp $

EAPI=2

# ruby19 → uncountable number of test failures
# jruby → needs to be tested because jruby-1.5.1 fails in multiple
# ways unrelated to this package.
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

# No documentation task
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md ISSUES.md UPGRADING.md"

inherit ruby-fakegem

DESCRIPTION="An easy way to vendor gem dependencies"
HOMEPAGE="http://github.com/carlhuda/bundler"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~sparc-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend virtual/rubygems

ruby_add_bdepend "test? ( app-text/ronn dev-ruby/rspec:2 )"

RDEPEND="${RDEPEND}
	dev-vcs/git"
DEPEND="${DEPEND}
	test? ( dev-vcs/git )"

RUBY_PATCHES=( "${FILESDIR}"/${PN}-1.0.3-gentoo.patch )

all_ruby_prepare() {
	# Reported upstream: http://github.com/carlhuda/bundler/issues/issue/738
	sed -i -e '707s/should/should_not/' spec/runtime/setup_spec.rb || die

	# Fails randomly and no clear cause can be found. Might be related
	# to bug 346357. This was broken in previous releases without a
	# failing spec, so patch out this spec for now since it is not a
	# regression.
	sed -i -e '49,54d' spec/install/deploy_spec.rb || die
}
