# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.5.0.ebuild,v 1.1 2003/08/06 13:38:06 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="~alpha ~x86"
DEPEND="${DEPEND} >=gnome-base/libglade-2"
RDEPEND="${RDEPEND} >=gnome-base/libglade-2
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} ) : ( >=dev-ruby/ruby-gtk2-${PV} )"
