# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.12.0.ebuild,v 1.10 2006/12/31 14:36:53 zmedico Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/gconf-2"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"

src_test() {
	addpredict /root/.gconf
	addpredict /root/.gconfd

	cd tests
	#ruby test.rb || die "test.rb failed"
	ruby -I../src/lib -I../src unittest.rb || die "unittest.rb failed"
}
