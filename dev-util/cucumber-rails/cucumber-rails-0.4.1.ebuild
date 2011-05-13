# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber-rails/cucumber-rails-0.4.1.ebuild,v 1.1 2011/05/13 07:15:33 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""

# There are also cucumber features. Most require capybara which we don't
# provide yet.
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRAINSTALL="generators templates"
RUBY_FAKEGEM_EXTRADOC="HACKING.rdoc History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios for Rails"
HOMEPAGE="http://github.com/aslakhellesoy/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "
	>=dev-util/cucumber-0.10.1
	>=dev-ruby/nokogiri-1.4.4
	>=dev-ruby/rack-test-0.5.7"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_doins VERSION
}
