# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.19.0.ebuild,v 1.1 2009/07/16 09:13:16 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="firefox xulrunner"
USE_RUBY="ruby18"
DEPEND="xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-gtkmozembed.h-fix.patch" )
