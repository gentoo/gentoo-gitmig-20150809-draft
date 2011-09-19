# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/will_paginate/will_paginate-3.0.1.ebuild,v 1.1 2011/09/19 08:14:16 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Most awesome pagination solution for Ruby  "
HOMEPAGE="http://github.com/mislav/will_paginate/"

LICENSE="as-is"
SLOT="3"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/rspec:2
		dev-ruby/rails:3.0
	)"
