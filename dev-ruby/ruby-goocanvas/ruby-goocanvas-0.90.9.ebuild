# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-goocanvas/ruby-goocanvas-0.90.9.ebuild,v 1.1 2011/09/17 14:46:40 naota Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby binding of GooCanvas"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	x11-libs/goocanvas:0"
DEPEND="${DEPEND}
	x11-libs/goocanvas:0"

ruby_add_bdepend "dev-ruby/pkg-config"
ruby_add_rdepend "dev-ruby/rcairo"
