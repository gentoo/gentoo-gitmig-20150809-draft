# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heckle/heckle-1.4.3.ebuild,v 1.1 2009/07/11 05:15:32 graaff Exp $

inherit ruby gems

DESCRIPTION="Unit Test Sadism"
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/ruby2ruby-1.1.6
	>=dev-ruby/parsetree-2.0.0
	>=dev-ruby/zentest-3.5.2"
RDEPEND="${DEPEND}"
