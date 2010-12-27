# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec-core/rspec-core-2.0.0_beta22.ebuild,v 1.4 2010/12/27 21:00:45 grobian Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_EXTRADOC="README.markdown Upgrade.markdown"

RUBY_FAKEGEM_EXTRAINSTALL="autotest"

RUBY_FAKEGEM_VERSION="2.0.0.beta.22"

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"
SRC_URI="mirror://rubygems/${PN}-${RUBY_FAKEGEM_VERSION}.gem"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "dev-ruby/syntax"

ruby_add_rdepend "
	~dev-ruby/rspec-expectations-${PV}
	~dev-ruby/rspec-mocks-${PV}"

#	>=dev-ruby/cucumber-0.5.3
#	>=dev-ruby/autotest-4.2.9
#	dev-ruby/aruba"

all_ruby_prepare() {
	# Don't set up bundler: it doesn't understand our setup.
	# Instead include rspec's version to fix an issue with the rdoc task.
	sed -i -e 's|require "bundler"|require "rspec/core/version"|' Rakefile || die
	sed -i -e '/Bundler/d' Rakefile || die

	# Remove the Gemfile to avoid running through 'bundle exec'
	rm Gemfile || die

	# Also clean the /usr/lib/rubyee path (which is our own invention).
	sed -i -e 's#lib\\d\*\\/ruby\\/#lib\\d*\\/ruby(ee|)\\/#' lib/rspec/core/configuration.rb || die
}

each_ruby_test() {
	PATH="${S}/bin:${PATH}" RUBYLIB="${S}/lib" ${RUBY} -S rake spec

	# There are features but they require aruba which we don't have yet.
}
