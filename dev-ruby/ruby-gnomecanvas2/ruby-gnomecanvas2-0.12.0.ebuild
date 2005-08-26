# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.12.0.ebuild,v 1.5 2005/08/26 17:00:32 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/libgnomecanvas-2.2"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
