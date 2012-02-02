# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/little-plugger/little-plugger-1.1.3.ebuild,v 1.2 2012/02/02 22:01:17 tomka Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Module that provides Gem based plugin management"
HOMEPAGE="http://github.com/TwP/${PN}"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend "
	doc? (
		dev-ruby/bones
	)
	test? (
		dev-ruby/bones
		dev-ruby/rspec:0
	)"

all_ruby_prepare() {
	# Remove default metadata because it confused jruby.
	rm ../metadata || die
}

each_ruby_test() {
	${RUBY} -S spec spec || die "tests failed"
}
