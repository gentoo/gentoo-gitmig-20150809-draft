# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomeprint/ruby-gnomeprint-0.19.4.ebuild,v 1.2 2010/07/26 13:32:26 fauli Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby bindings for gnomeprint"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=gnome-base/libgnomeprint-2.8"
DEPEND="${DEPEND}
	>=gnome-base/libgnomeprint-2.8
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
