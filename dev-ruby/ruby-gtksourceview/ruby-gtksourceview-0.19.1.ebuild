# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-0.19.1.ebuild,v 1.3 2010/01/10 18:14:25 nixnut Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND="=x11-libs/gtksourceview-1*"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"
