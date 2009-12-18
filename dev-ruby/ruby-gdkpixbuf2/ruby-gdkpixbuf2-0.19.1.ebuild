# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.19.1.ebuild,v 1.3 2009/12/18 15:07:29 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND=">=dev-ruby/ruby-glib2-${PV}
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
