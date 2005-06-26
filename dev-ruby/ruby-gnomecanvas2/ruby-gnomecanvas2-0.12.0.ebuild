# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.12.0.ebuild,v 1.2 2005/06/26 15:32:42 usata Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="~alpha x86 ~ppc ~ia64 ~sparc ~amd64"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/libgnomecanvas-2.2"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
