# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-geoip/net-geoip-0.06.ebuild,v 1.5 2005/03/25 23:37:01 blubb Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby bindings for the GeoIP library"
HOMEPAGE="http://www.maxmind.com/app/ruby"
SRC_URI="http://www.rubynet.org/modules/net/geoip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND="virtual/ruby
	>=dev-libs/geoip-1.2.1"
USE_RUBY="ruby16 ruby18 ruby19"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc README TODO
}
