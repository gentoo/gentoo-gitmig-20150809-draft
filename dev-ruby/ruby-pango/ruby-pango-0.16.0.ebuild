# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-0.16.0.ebuild,v 1.5 2007/03/28 15:50:05 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="~alpha ~amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=x11-libs/pango-1.2.1
	>=dev-ruby/rcairo-1.2.0"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
