# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heckle/heckle-1.4.3.ebuild,v 1.3 2010/02/13 19:19:51 armin76 Exp $

inherit ruby gems

DESCRIPTION="Unit Test Sadism"
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/ruby2ruby-1.1.6
	>=dev-ruby/parsetree-2.0.0
	>=dev-ruby/zentest-3.5.2"
RDEPEND="${DEPEND}"
