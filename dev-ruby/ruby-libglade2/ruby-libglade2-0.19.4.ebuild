# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.19.4.ebuild,v 1.5 2010/08/28 17:38:56 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE="gnome"

RDEPEND="${RDEPEND}
	>=gnome-base/libglade-2"
DEPEND="${DEPEND}
	>=gnome-base/libglade-2
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-glib2-${PV}
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )"
