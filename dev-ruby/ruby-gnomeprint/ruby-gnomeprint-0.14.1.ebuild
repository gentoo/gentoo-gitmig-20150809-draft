# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomeprint/ruby-gnomeprint-0.14.1.ebuild,v 1.1 2005/11/15 11:03:54 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gnomeprint"
KEYWORDS="~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/libgnomeprint-2.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-libart2-${PV}"

