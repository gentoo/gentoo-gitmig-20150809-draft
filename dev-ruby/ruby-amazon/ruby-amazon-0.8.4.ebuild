# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-amazon/ruby-amazon-0.8.4.ebuild,v 1.1 2004/09/21 21:57:10 citizen428 Exp $

inherit ruby

IUSE="geoip"
USE_RUBY="ruby18"

DESCRIPTION="A Ruby interface to Amazon web services"
HOMEPAGE="http://www.caliban.org/ruby/ruby-amazon.shtml"
SRC_URI="http://www.caliban.org/files/ruby/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/ruby
	geoip? ( >=dev-ruby/net-geoip-0.06 )"
