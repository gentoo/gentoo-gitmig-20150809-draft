# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.16.0.ebuild,v 1.9 2008/12/09 14:32:06 fmccor Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86"
IUSE="firefox seamonkey xulrunner"
USE_RUBY="ruby18 ruby19"
DEPEND="xulrunner? ( =net-libs/xulrunner-1.8* )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack()
{
	ruby_src_unpack
	use seamonkey && epatch "${FILESDIR}/${PN}-${PV}-seamonkey.patch"
}
