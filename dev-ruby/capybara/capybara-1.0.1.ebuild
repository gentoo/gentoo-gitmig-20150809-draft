# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/capybara/capybara-1.0.1.ebuild,v 1.1 2011/08/12 17:59:18 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

# Rake tasks are not distributed in the gem.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Capybara aims to simplify the process of integration testing Rack applications."
HOMEPAGE="http://github.com/jnicklas/capybara"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE="test"

# Restrict tests since they will try to launch a browser to run tests
# in. All tests should pass. Launchy can be found in the ruby overlay.
RESTRICT="test"

#ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/launchy www-client/firefox )"

ruby_add_rdepend "
	>=dev-ruby/mime-types-1.16
	>=dev-ruby/nokogiri-1.3.3
	>=dev-ruby/rack-1.0.0
	>=dev-ruby/rack-test-0.5.4

	>=dev-ruby/selenium-webdriver-2.0
	>=dev-ruby/xpath-0.1.4"

all_ruby_prepare() {
	sed -i -e '/bundler/d' spec/spec_helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib -S rspec spec || die "Tests failed."
}
