# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/loquacious/loquacious-1.7.0.ebuild,v 1.1 2010/08/17 05:57:44 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Descriptive configuration files for Ruby written in Ruby"
HOMEPAGE="http://github.com/TwP/${PN}"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "test? ( dev-ruby/rspec )"

all_ruby_compile() {
	rdoc lib || die "Documentation generation failed."
}

each_ruby_test() {
	${RUBY} -S spec spec || die "Tests failed."
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
