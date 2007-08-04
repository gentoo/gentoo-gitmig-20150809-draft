# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libgda/ruby-libgda-0.12.0.ebuild,v 1.7 2007/08/04 13:37:32 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby libgda (GNOME-DB) bindings"
KEYWORDS="alpha ia64 ~ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="=gnome-extra/libgda-1*"
RDEPEND=">=dev-ruby/ruby-glib2-${PV}"

src_test() {
	cd tests
	ruby tc_all.rb || die "tc_all.rb failed"
}
