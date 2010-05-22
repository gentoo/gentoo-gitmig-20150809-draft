# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/little-plugger/little-plugger-1.1.2-r1.ebuild,v 1.2 2010/05/22 13:18:32 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec:specdoc"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Module that provides Gem based plugin management"
HOMEPAGE="http://github.com/TwP/${PN}"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "
	doc? (
		dev-ruby/bones
		dev-ruby/bones-extras
	)
	test? (
		dev-ruby/bones
		dev-ruby/bones-extras
		dev-ruby/rspec
	)"

all_ruby_prepare() {
	# needed for proper work with Ruby 1.9, without updated RubyGems;
	# reported upstream
	epatch "${FILESDIR}"/${P}-rubylib.patch
}
