# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.10.3.ebuild,v 1.1 2012/01/23 06:44:00 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test:units"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc RELEASE.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/coderay )"

ruby_add_rdepend "dev-ruby/metaclass" #metaclass ~> 0.0.1

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/ s:^:#:' -e '1iload "lib/mocha/version.rb"' Rakefile || die
}

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
