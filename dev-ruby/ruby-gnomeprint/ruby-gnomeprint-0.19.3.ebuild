# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomeprint/ruby-gnomeprint-0.19.3.ebuild,v 1.1 2010/01/14 17:25:31 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby bindings for gnomeprint"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeprint-2.8"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
