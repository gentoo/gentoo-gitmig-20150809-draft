# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.0.ebuild,v 1.3 2009/05/03 19:59:48 graaff Exp $

inherit gems

MY_P=${P/rcairo/cairo}

IUSE=""

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

USE_RUBY="ruby18"

RDEPEND=">=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
