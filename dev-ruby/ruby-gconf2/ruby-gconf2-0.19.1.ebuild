# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.19.1.ebuild,v 1.4 2009/12/18 15:09:33 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND=">=gnome-base/gconf-2
	dev-util/pkgconfig"
RDEPEND=">=gnome-base/gconf-2
	>=dev-ruby/ruby-glib2-${PV}"
