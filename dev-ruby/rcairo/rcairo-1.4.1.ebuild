# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.4.1.ebuild,v 1.6 2008/04/06 17:25:11 graaff Exp $

inherit ruby

IUSE="examples"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

RDEPEND=">=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
