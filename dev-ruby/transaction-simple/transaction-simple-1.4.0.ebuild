# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.4.0.ebuild,v 1.2 2007/06/16 14:20:33 dertobi123 Exp $

inherit ruby gems

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://rubyforge.org/projects/trans-simple/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

USE_RUBY="any"
DEPEND=">=dev-ruby/hoe-1.1.7"
RDEPEND=">=dev-ruby/hoe-1.1.7"

