# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/loquacious/loquacious-1.9.1.ebuild,v 1.1 2011/12/18 14:19:14 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Descriptive configuration files for Ruby written in Ruby"
HOMEPAGE="http://github.com/TwP/${PN}"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.6.0:2 )"

all_ruby_prepare() {
	# Remove metadata because it confuses jruby.
	rm ../metadata || die
}

all_ruby_compile() {
	rdoc lib || die "Documentation generation failed."
}

each_ruby_test() {
	${RUBY} -S rspec spec || die "Tests failed."
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/*
}
