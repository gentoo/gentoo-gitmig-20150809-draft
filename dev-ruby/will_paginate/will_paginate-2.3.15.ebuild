# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/will_paginate/will_paginate-2.3.15.ebuild,v 1.2 2011/01/10 18:18:36 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Most awesome pagination solution for Ruby  "
HOMEPAGE="http://github.com/mislav/will_paginate/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/mocha
		dev-ruby/rack
		dev-ruby/activerecord
		virtual/ruby-test-unit
		!dev-ruby/test-unit:2
	)"
ruby_add_rdepend '>=dev-ruby/activesupport-1.4.4'
