# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.16.0.ebuild,v 1.8 2008/10/06 14:09:56 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
RDEPEND=">=gnome-base/libgnomecanvas-2.2
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
DEPEND=">=gnome-base/libgnomecanvas-2.2
	dev-util/pkgconfig"
