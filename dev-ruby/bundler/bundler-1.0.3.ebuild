# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bundler/bundler-1.0.3.ebuild,v 1.1 2010/10/16 08:29:47 graaff Exp $

EAPI=2

# ruby19 → uncountable number of test failures
# jruby → needs to be tested because jruby-1.5.1 fails in multiple
# ways unrelated to this package
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
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend dev-ruby/rubygems

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

RDEPEND="${RDEPEND}
	dev-vcs/git"
DEPEND="${DEPEND}
	test? ( dev-vcs/git )"

RUBY_PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

all_ruby_prepare() {
	# Reported upstream: http://github.com/carlhuda/bundler/issues#issue/771
	sed -i -e 's:Your bundle was installed to `vendor`:It was installed into ./vendor:' -e 's:Your bundle was installed to `vendor/bundle`:It was installed into ./vendor/bundle:' spec/install/gems/simple_case_spec.rb || die

	# Reported upstream: http://github.com/carlhuda/bundler/issues/issue/738
	sed -i -e '159s/should/should_not/' spec/runtime/environment_rb_spec.rb || die
}
