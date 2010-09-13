# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec-mocks/rspec-mocks-2.0.0_beta22.ebuild,v 1.1 2010/09/13 18:03:15 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_TASK_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.markdown"

RUBY_FAKEGEM_VERSION="2.0.0.beta.22"

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"
SRC_URI="mirror://rubygems/${PN}-${RUBY_FAKEGEM_VERSION}.gem"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

# cucumber and rspec-core are loaded unconditionally in the Rakefile,
# so we also need to require them for USE=doc.
ruby_add_bdepend "test? (
		~dev-ruby/rspec-core-${PV}
		~dev-ruby/rspec-expectations-${PV}
		dev-util/cucumber
	)
	doc? ( ~dev-ruby/rspec-core-${PV} dev-util/cucumber )"

# Not clear yet to what extend we need those (now)
#	>=dev-ruby/cucumber-0.6.2
#	>=dev-ruby/aruba-0.1.1"

all_ruby_prepare() {
	# Don't set up bundler: it doesn't understand our setup.
	sed -i -e "s|require 'bundler'|require 'rspec/mocks/version'|" Rakefile || die
	sed -i -e '/Bundler/d' Rakefile || die

	# Remove the Gemfile to avoid running through 'bundle exec'
	rm Gemfile || die
}

all_ruby_compile() {
	RUBYLIB="${S}/lib" rake rdoc || die
}

each_ruby_test() {
	PATH="${S}/bin:${PATH}" RUBYLIB="${S}/lib" ${RUBY} -S rake spec || die

	# There are features but they require aruba which we don't have yet.
}
