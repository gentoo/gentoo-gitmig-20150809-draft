# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-0.16.0.ebuild,v 1.6 2008/04/02 07:56:37 opfer Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="=x11-libs/gtksourceview-1*"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"
