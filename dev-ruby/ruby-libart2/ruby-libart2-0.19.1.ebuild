# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libart2/ruby-libart2-0.19.1.ebuild,v 1.3 2009/12/18 15:08:17 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Libart2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND=">=media-libs/libart_lgpl-2
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
