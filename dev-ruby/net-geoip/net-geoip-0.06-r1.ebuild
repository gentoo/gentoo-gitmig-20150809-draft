# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-geoip/net-geoip-0.06-r1.ebuild,v 1.5 2006/10/20 21:11:28 agriffis Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby bindings for the GeoIP library"
HOMEPAGE="http://www.maxmind.com/app/ruby"
SRC_URI="http://www.rubynet.org/modules/net/geoip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"

DEPEND="virtual/ruby
	>=dev-libs/geoip-1.2.1"
USE_RUBY="ruby16 ruby18 ruby19"
PATCHES="${FILESDIR}/${PN}-0.06-extconf.patch"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc README TODO
}
