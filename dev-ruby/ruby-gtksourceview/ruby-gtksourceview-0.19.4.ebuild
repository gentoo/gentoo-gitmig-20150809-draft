# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-0.19.4.ebuild,v 1.6 2011/03/23 16:50:11 eva Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="amd64 ~ia64 ppc sparc x86"
IUSE=""

RDEPEND="${RDEPEND}
	x11-libs/gtksourceview:1.0"
DEPEND="${DEPEND}
	x11-libs/gtksourceview:1.0
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}"
