# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.3.0.ebuild,v 1.6 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://trans-simple.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/4334/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
IUSE=""

USE_RUBY="any"
DEPEND="virtual/ruby"
