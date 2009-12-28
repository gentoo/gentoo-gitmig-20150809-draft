# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fakeweb/fakeweb-1.2.8.ebuild,v 1.1 2009/12/28 12:13:35 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Helper for faking web requests in Ruby"
HOMEPAGE="http://github.com/chrisk/fakeweb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend test '>=dev-ruby/mocha-0.9.5 virtual/ruby-test-unit'
