# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.9.8-r3.ebuild,v 1.1 2010/08/16 22:36:47 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test:units"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README RELEASE"

inherit ruby-fakegem

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~flameeyes/patches/${PN}/${P}+ruby-1.9.2.patch.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend "
	test? ( virtual/ruby-test-unit )
	doc? ( dev-ruby/coderay )"

RUBY_PATCHES=( "${DISTDIR}"/${P}+ruby-1.9.2-r2.patch.bz2 )

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
