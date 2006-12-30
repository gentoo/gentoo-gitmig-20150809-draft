# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.16.0.ebuild,v 1.1 2006/12/30 04:37:17 metalgod Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/libgnomecanvas-2.2"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
