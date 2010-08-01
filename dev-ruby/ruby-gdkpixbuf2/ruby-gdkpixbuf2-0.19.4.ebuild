# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.19.4.ebuild,v 1.3 2010/08/01 09:48:42 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="${RDEPEND} >=x11-libs/gtk+-2"
DEPEND="${DEPEND}
	>=x11-libs/gtk+-2
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
