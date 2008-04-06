# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.16.0.ebuild,v 1.7 2008/04/06 17:28:28 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=x11-libs/gtk+-2.0.0
	dev-util/pkgconfig"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
