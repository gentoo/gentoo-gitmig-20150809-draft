# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber-rails/cucumber-rails-1.2.1.ebuild,v 1.2 2012/01/29 10:41:12 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""

# There are also cucumber features. They require a Rails project with
# factory girl which we don't have packaged yet.
RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="History.md README.md"

RUBY_FAKEGEM_GEMSPEC="cucumber-rails.gemspec"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios for Rails"
HOMEPAGE="http://github.com/aslakhellesoy/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64"
SLOT="1"
IUSE=""

ruby_add_bdepend "test? (
		>=dev-ruby/rspec-2.6:2
		>=dev-ruby/ammeter-0.2.1
	)"

ruby_add_rdepend "
	>=dev-util/cucumber-1.1.3
	>=dev-ruby/nokogiri-1.5.0
	>=dev-ruby/capybara-1.1.2"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}
