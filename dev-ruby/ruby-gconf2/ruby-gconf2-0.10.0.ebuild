# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.10.0.ebuild,v 1.1 2004/08/09 03:00:22 usata Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="~alpha ~x86 ~ia64 ~ppc ~amd64"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="${DEPEND} >=gnome-base/gconf-2"
RDEPEND="${RDEPEND} >=gnome-base/gconf-2
	>=dev-ruby/ruby-glib2-${PV}"
