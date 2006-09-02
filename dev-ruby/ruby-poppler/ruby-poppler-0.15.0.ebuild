# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.15.0.ebuild,v 1.1 2006/09/02 00:49:14 pclouds Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=app-text/poppler-bindings-0.5.2
	dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
pkg_setup()
{
	pkg-config --exists poppler-glib ||
		die "You have to emerge poppler-bindings with USE flag gtk"
}
