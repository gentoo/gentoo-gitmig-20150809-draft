# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.6.2.ebuild,v 1.1 2008/07/04 18:51:28 graaff Exp $

inherit ruby

IUSE="examples"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

RDEPEND=">=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
