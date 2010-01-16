# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-debug/ruby-debug-0.10.3.ebuild,v 1.3 2010/01/16 16:00:59 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="CLI interface to ruby-debug"
HOMEPAGE="http://rubyforge.org/projects/ruby-debug/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=dev-ruby/ruby-debug-base-0.10.3
	>=dev-ruby/columnize-0.1
	>=dev-lang/ruby-1.8.4"
RDEPEND="${DEPEND}"
