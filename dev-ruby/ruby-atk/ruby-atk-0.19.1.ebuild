# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-atk/ruby-atk-0.19.1.ebuild,v 1.4 2010/01/10 18:01:03 nixnut Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Atk bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND="dev-libs/atk"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
