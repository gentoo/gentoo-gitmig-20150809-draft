# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.9.8-r2.ebuild,v 1.3 2010/01/14 15:40:11 ranger Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test:units"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README RELEASE"

inherit ruby-fakegem

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit
ruby_add_bdepend doc dev-ruby/coderay

all_ruby_compile() {
	all_fakegem_compile

	if use doc; then
		rake examples || die
	fi
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/*.rb || die
}
