# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-0.14.1.ebuild,v 1.1 2005/11/15 10:59:16 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="x11-libs/gtksourceview"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}"
