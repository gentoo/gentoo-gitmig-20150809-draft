# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.0.ebuild,v 1.1 2008/10/16 09:21:53 flameeyes Exp $

inherit gems

MY_P=${P/rcairo/cairo}

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

RDEPEND=">=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
