# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-0.8.1.ebuild,v 1.1 2004/01/23 07:56:16 usata Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="~alpha ~x86"
DEPEND="${DEPEND}
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2"
RDEPEND="${RDEPEND}
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=dev-ruby/ruby-gnomecanvas2-${PV}"
