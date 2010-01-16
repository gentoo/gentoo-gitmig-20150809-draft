# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.19.3.ebuild,v 1.1 2010/01/16 06:26:44 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/poppler-glib-0.8.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

ruby_add_rdepend "dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
