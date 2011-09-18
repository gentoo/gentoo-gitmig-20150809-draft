# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.90.9.ebuild,v 1.2 2011/09/18 03:52:50 naota Exp $

EAPI="3"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="${RDEPEND} >=dev-libs/glib-2"
DEPEND="${DEPEND}
	>=dev-libs/glib-2"

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}
