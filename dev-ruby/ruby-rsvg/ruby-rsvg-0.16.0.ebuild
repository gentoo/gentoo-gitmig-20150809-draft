# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-0.16.0.ebuild,v 1.3 2008/04/08 05:20:26 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="cairo"
USE_RUBY="ruby18 ruby19"

RDEPEND="
	>=gnome-base/librsvg-2.8
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}
	cairo? ( dev-ruby/rcairo )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
