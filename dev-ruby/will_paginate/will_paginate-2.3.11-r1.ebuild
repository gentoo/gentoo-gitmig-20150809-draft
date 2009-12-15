# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/will_paginate/will_paginate-2.3.11-r1.ebuild,v 1.2 2009/12/15 19:59:15 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Most awesome pagination solution for Ruby  "
HOMEPAGE="http://github.com/mislav/will_paginate/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

ruby_add_bdepend test dev-ruby/mocha
ruby_add_rdepend '>=dev-ruby/activesupport-1.4.4'
