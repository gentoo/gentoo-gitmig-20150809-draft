# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.8.0.ebuild,v 1.5 2005/04/01 06:01:59 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="alpha x86 ia64"
IUSE=""
DEPEND="${DEPEND} >=gnome-base/libgnomecanvas-2.2"
RDEPEND="${RDEPEND} >=gnome-base/libgnomecanvas-2.2
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
