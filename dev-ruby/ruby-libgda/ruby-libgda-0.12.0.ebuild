# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libgda/ruby-libgda-0.12.0.ebuild,v 1.1 2005/03/14 19:49:36 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby libgda (GNOME-DB) bindings"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-extra/libgda-1.0.3"
RDEPEND=">=dev-ruby/ruby-glib2-${PV}"

src_test() {
	cd tests
	ruby tc_all.rb || die "tc_all.rb failed"
}
