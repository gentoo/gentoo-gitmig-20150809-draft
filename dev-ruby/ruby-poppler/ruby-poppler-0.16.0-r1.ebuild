# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.16.0-r1.ebuild,v 1.2 2008/06/04 15:55:57 mr_bones_ Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
RDEPEND=">=app-text/poppler-bindings-0.5.2
	dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup()
{
	pkg-config --exists poppler-glib ||
		die "You have to emerge poppler-bindings with USE flag gtk"
}

PATCHES=( 	"${FILESDIR}/${P}-poppler-0.6.patch"
		"${FILESDIR}/${P}-poppler-0.7.patch" )
