# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.90.8.ebuild,v 1.4 2012/03/18 15:23:40 ranger Exp $

EAPI="3"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND="${RDEPEND} >=dev-libs/glib-2"
DEPEND="${DEPEND}
	>=dev-libs/glib-2"

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}
