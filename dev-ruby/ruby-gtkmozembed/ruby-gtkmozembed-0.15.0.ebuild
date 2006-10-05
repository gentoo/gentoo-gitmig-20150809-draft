# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.15.0.ebuild,v 1.2 2006/10/05 20:50:43 pclouds Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="firefox"
USE_RUBY="ruby18 ruby19"
DEPEND="firefox? ( >=www-client/mozilla-firefox-1.0 )
	!firefox? ( >=www-client/seamonkey-1.0 )"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
src_unpack()
{
	ruby_src_unpack
	use firefox && epatch "${FILESDIR}/${PN}-0.15.0-firefox.patch"
	use firefox || epatch "${FILESDIR}/${PN}-0.15.0-seamonkey.patch"
}
