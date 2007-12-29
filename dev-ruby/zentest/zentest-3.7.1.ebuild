# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-3.7.1.ebuild,v 1.1 2007/12/29 15:02:15 graaff Exp $

inherit ruby gems

MY_P=${P/zentest/ZenTest}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""

DEPEND="virtual/ruby
	>=dev-ruby/rubygems-0.9.1
	>=dev-ruby/hoe-1.4.0"
