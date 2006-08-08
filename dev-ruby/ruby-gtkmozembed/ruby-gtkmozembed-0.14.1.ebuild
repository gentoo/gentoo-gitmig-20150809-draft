# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.14.1.ebuild,v 1.3 2006/08/08 01:13:24 metalgod Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="firefox"
USE_RUBY="ruby18 ruby19"
DEPEND="firefox? ( >=www-client/mozilla-firefox-1.0 )
	!firefox? ( >=www-client/mozilla-1.7 )"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
