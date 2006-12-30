# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-vte/ruby-vte-0.16.0.ebuild,v 1.1 2006/12/30 04:49:06 metalgod Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby vte bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=x11-libs/vte-0.12.1
	>=dev-ruby/ruby-gtk2-${PV}"
