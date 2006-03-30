# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xml-simple/xml-simple-1.0.6.ebuild,v 1.2 2006/03/30 04:02:42 agriffis Exp $

inherit ruby

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Easy API to maintain XML. It is a Ruby port of Grant McLean's Perl module XML::Simple."
HOMEPAGE="http://www.maik-schmidt.de/xml-simple.html"
SRC_URI="http://home.nexgo.de/schmidt.maik/downloads/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""
USE_RUBY="any"

src_test() {
	cd test
	ruby tc_all.rb || die "tc_all.rb failed"
}
