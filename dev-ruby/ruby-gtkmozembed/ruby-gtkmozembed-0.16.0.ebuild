# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.16.0.ebuild,v 1.7 2008/05/15 20:47:55 maekke Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="seamonkey"
USE_RUBY="ruby18 ruby19"
DEPEND="seamonkey? ( >=www-client/seamonkey-1.0 )"
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
