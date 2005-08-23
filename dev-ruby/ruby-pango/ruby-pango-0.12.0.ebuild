# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-0.12.0.ebuild,v 1.7 2005/08/23 16:36:56 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=x11-libs/pango-1.2.1"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
