# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.19.0.ebuild,v 1.1 2009/07/16 07:49:12 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND=">=virtual/poppler-glib-0.8.0
	dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
