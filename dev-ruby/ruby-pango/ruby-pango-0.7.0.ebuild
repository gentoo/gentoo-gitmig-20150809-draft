# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-0.7.0.ebuild,v 1.2 2004/06/25 02:02:22 agriffis Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="~alpha ~x86"
DEPEND="${DEPEND} >=x11-libs/pango-1.2.1"
RDEPEND="${RDEPEND} >=x11-libs/pango-1.2.1 >=dev-ruby/ruby-glib2-${PV}"
