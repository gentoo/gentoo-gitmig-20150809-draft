# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/log_buddy/log_buddy-0.6.0.ebuild,v 1.1 2011/12/24 03:03:07 flameeyes Exp $

EAPI="4"

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.markdown examples.rb"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem eutils

DESCRIPTION="Log statements along with their name easily."
HOMEPAGE="https://github.com/relevance/log_buddy"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? ( virtual/ruby-rdoc )
	test? (
		dev-ruby/rspec
		>=dev-ruby/mocha-0.9
	)"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}
