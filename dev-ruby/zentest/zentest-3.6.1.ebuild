# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-3.6.1.ebuild,v 1.3 2007/09/05 14:29:50 angelos Exp $

inherit ruby gems

MY_P=${P/zentest/ZenTest}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="amd64 ia64 x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"
DEPEND="virtual/ruby
	>=dev-ruby/rubygems-0.9.1
	>=dev-ruby/hoe-1.2.2"
