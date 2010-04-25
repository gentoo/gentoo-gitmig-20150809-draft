# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-0.19.4.ebuild,v 1.1 2010/04/25 15:19:23 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="cairo"

RDEPEND="${RDEPEND}
	>=gnome-base/librsvg-2.8"
DEPEND="${DEPEND}
	>=gnome-base/librsvg-2.8
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}"
ruby_add_rdepend cairo dev-ruby/rcairo
