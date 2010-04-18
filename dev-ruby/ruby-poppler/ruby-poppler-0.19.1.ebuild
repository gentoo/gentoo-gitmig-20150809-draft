# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.19.1.ebuild,v 1.5 2010/04/18 12:25:09 nixnut Exp $

EAPI="2"

inherit ruby ruby-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="amd64 ppc x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND=">=app-text/poppler-0.12.3-r3[cairo]
	dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
