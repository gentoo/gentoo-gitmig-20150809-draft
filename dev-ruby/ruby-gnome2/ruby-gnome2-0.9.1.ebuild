# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnome2/ruby-gnome2-0.9.1.ebuild,v 1.5 2004/07/03 11:17:06 slarti Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby Gnome2 bindings"
KEYWORDS="~alpha ~x86 ~ia64 ~ppc ~sparc ~amd64"
DEPEND="${DEPEND} >=gnome-base/libgnome-2.2 >=gnome-base/libgnomeui-2.2"
RDEPEND="${RDEPEND} >=gnome-base/libgnome-2.2 >=gnome-base/libgnomeui-2.2
	>=dev-ruby/ruby-gnomecanvas2-${PV}"
