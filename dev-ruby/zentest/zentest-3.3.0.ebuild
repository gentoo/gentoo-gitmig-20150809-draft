# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-3.3.0.ebuild,v 1.3 2006/12/23 19:06:16 welp Exp $

inherit ruby gems

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

MY_P=${P/zentest/ZenTest}
S=${WORKDIR}/${MY_P}

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="amd64 ~ia64 x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"
DEPEND="virtual/ruby"
