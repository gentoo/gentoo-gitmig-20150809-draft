# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.10.1.ebuild,v 1.3 2005/04/01 06:01:59 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="alpha x86 ~ppc ia64 ~sparc ~amd64"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="${DEPEND} >=gnome-base/libgnomecanvas-2.2"
RDEPEND="${RDEPEND} >=gnome-base/libgnomecanvas-2.2
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
