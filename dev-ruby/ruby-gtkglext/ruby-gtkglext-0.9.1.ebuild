# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkglext/ruby-gtkglext-0.9.1.ebuild,v 1.1 2004/03/18 23:45:13 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GtkGLExt bindings"
KEYWORDS="~alpha ~x86 ~ppc ~ia64"
DEPEND="${DEPEND} >=x11-libs/gtkglext-1.0.3"
RDEPEND="${RDEPEND} >=x11-libs/gtkglext-1.0.3"
