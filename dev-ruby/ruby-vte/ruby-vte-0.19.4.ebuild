# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-vte/ruby-vte-0.19.4.ebuild,v 1.3 2010/08/01 09:58:37 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby vte bindings"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=x11-libs/vte-0.12.1"
DEPEND="${DEPEND}
	>=x11-libs/vte-0.12.1
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}"
