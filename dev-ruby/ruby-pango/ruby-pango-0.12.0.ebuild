# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-0.12.0.ebuild,v 1.6 2005/08/13 23:18:19 hansmi Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=x11-libs/pango-1.2.1"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
