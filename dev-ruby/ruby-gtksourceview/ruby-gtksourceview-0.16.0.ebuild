# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-0.16.0.ebuild,v 1.1 2006/12/30 04:47:35 metalgod Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="x11-libs/gtksourceview"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gtk2-${PV}"
