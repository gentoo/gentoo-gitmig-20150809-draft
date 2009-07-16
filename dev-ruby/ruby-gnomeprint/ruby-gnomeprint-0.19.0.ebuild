# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomeprint/ruby-gnomeprint-0.19.0.ebuild,v 1.1 2009/07/16 08:50:45 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gnomeprint"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND=">=gnome-base/libgnomeprint-2.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"
