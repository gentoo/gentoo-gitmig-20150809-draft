# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-0.14.1.ebuild,v 1.1 2005/11/15 10:57:06 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/librsvg-2.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}"
