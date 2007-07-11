# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jabber4r/jabber4r-0.8.0.ebuild,v 1.8 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

DESCRIPTION="A Jabber library in pure Ruby"
HOMEPAGE="http://jabber4r.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ia64 ~ppc64 x86"
IUSE=""

USE_RUBY="ruby18 ruby19"
