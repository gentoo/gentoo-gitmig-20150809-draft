# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.8.1.ebuild,v 1.1 2003/11/24 19:00:34 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="~alpha ~x86"
DEPEND="${DEPEND} >=media-libs/gdk-pixbuf-0.21.0"
RDEPEND="${RDEPEND} >=media-libs/gdk-pixbuf-0.21.0 >=dev-ruby/ruby-glib2-${PV}"
