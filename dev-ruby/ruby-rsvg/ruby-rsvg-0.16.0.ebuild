# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-0.16.0.ebuild,v 1.1 2006/12/30 13:56:49 metalgod Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/librsvg-2.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}"
