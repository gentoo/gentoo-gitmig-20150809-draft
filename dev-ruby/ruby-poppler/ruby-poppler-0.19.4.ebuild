# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.19.4.ebuild,v 1.3 2010/08/01 09:57:30 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=app-text/poppler-0.12.3-r3[cairo]"
DEPEND="${DEPEND}
	>=app-text/poppler-0.12.3-r3[cairo]
	dev-util/pkgconfig"

ruby_add_rdepend "dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}"
