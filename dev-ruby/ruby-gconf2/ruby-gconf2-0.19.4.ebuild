# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf2/ruby-gconf2-0.19.4.ebuild,v 1.6 2012/05/01 18:24:23 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GConf2 bindings"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
DEPEND="${DEPEND}
	>=gnome-base/gconf-2
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	>=gnome-base/gconf-2"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
