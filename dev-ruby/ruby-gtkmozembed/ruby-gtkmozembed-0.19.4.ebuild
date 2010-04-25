# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.19.4.ebuild,v 1.1 2010/04/25 15:51:29 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="firefox xulrunner"

RDEPEND="${RDEPEND}
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )"
DEPEND="${DEPEND}
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	dev-util/pkgconfig"

RUBY_PATCHES=( "${P}-xulrunner-1.9.2.patch" )

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
