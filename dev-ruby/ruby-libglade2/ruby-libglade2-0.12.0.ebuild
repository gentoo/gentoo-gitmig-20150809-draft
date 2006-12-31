# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.12.0.ebuild,v 1.9 2006/12/31 14:42:03 zmedico Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc ~sparc x86"
IUSE="gnome"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/libglade-2"
RDEPEND="${DEPEND}
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )
	!gnome? ( >=dev-ruby/ruby-gtk2-${PV} )"
