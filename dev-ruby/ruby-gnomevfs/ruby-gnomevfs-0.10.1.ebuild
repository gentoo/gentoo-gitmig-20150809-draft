# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomevfs/ruby-gnomevfs-0.10.1.ebuild,v 1.2 2004/08/30 23:30:09 dholm Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeVFS bindings"
KEYWORDS="~x86 ~ppc"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/gnome-vfs-2.2"

src_test() {
	cd tests
	ruby test1.rb || die "test1.rb failed"
	ruby test2.rb || die "test2.rb failed"
	ruby test3.rb || die "test3.rb failed"
}
