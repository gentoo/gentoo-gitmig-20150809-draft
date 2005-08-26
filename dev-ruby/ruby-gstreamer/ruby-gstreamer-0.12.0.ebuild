# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-0.12.0.ebuild,v 1.4 2005/08/26 17:01:29 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="alpha ia64 ~ppc x86"
USE_RUBY="ruby16 ruby18 ruby19"
IUSE=""
DEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=media-libs/gstreamer-0.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gnomecanvas2-${PV}"

src_test() {
	cd tests
	ruby tc_all.rb || die "tc_all.rb test failed"
}
