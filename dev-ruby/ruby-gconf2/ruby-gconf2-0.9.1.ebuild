# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.9.1.ebuild,v 1.1 2004/03/18 23:33:55 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="~alpha ~x86 ~ia64"
DEPEND="${DEPEND} >=gnome-base/gconf-2"
RDEPEND="${RDEPEND} >=gnome-base/gconf-2
	>=dev-ruby/ruby-glib2-${PV}"
