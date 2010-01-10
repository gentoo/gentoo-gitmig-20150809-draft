# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.19.1.ebuild,v 1.3 2010/01/10 18:16:03 nixnut Exp $

inherit eutils ruby ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86"
IUSE="gnome"
USE_RUBY="ruby18"
RDEPEND="
	>=gnome-base/libglade-2
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )
	!gnome? ( >=dev-ruby/ruby-gtk2-${PV} )
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
