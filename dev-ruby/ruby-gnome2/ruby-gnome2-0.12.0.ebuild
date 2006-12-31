# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnome2/ruby-gnome2-0.12.0.ebuild,v 1.7 2006/12/31 04:37:33 metalgod Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby Gnome2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc ~sparc x86"
IUSE=""
DEPEND="${DEPEND} >=gnome-base/libgnome-2.2 >=gnome-base/libgnomeui-2.2"
RDEPEND="${RDEPEND} >=gnome-base/libgnome-2.2 >=gnome-base/libgnomeui-2.2
	>=dev-ruby/ruby-gnomecanvas2-${PV}"
