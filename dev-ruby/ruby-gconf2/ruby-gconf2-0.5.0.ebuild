# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.5.0.ebuild,v 1.1 2003/08/06 13:35:43 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="~alpha ~x86"
DEPEND="${DEPEND} >=gnome-base/gconf-2"
RDEPEND="${RDEPEND} >=gnome-base/gconf-2
	>=dev-ruby/ruby-glib2-${PV}"
