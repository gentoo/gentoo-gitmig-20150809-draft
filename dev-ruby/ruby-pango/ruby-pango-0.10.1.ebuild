# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-0.10.1.ebuild,v 1.5 2005/05/22 03:16:00 weeve Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="${DEPEND} >=x11-libs/pango-1.2.1"
RDEPEND="${RDEPEND} >=x11-libs/pango-1.2.1 >=dev-ruby/ruby-glib2-${PV}"
