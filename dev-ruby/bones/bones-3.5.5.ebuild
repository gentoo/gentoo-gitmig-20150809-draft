# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bones/bones-3.5.5.ebuild,v 1.1 2011/01/11 07:10:13 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec:specdoc"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="default version.txt"

inherit ruby-fakegem

DESCRIPTION="Tool that creates new Ruby projects from a code skeleton"
HOMEPAGE="http://github.com/TwP/bones"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	>=dev-ruby/loquacious-1.7.0
	>=dev-ruby/little-plugger-1.1.2-r1
	>=dev-ruby/rake-0.8.7"

ruby_add_bdepend "
	test? (
		>=dev-ruby/bones-extras-1.2.2
		>=dev-ruby/rspec-1.2.9:0
	)
	doc? ( >=dev-ruby/bones-extras-1.2.2 )"

all_ruby_prepare() {
	# Avoid double --format specdoc option which causes problems for rspec.
	sed -i -e 's/--format specdoc//' Rakefile || die
}
