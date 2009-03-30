# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.16.0-r1.ebuild,v 1.3 2009/03/30 15:18:25 loki_val Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
RDEPEND=">=virtual/poppler-glib-0.5.2
	dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( 	"${FILESDIR}/${P}-poppler-0.6.patch"
		"${FILESDIR}/${P}-poppler-0.7.patch" )
