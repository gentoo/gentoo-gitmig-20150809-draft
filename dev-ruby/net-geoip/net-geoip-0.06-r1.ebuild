# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-geoip/net-geoip-0.06-r1.ebuild,v 1.7 2009/02/08 20:25:30 a3li Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby bindings for the GeoIP library"
HOMEPAGE="http://www.maxmind.com/app/ruby"
SRC_URI="http://www.rubynet.org/modules/net/geoip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 x86"

DEPEND="=dev-lang/ruby-1.8*
	>=dev-libs/geoip-1.2.1"
RDEPEND="${DEPEND}"

USE_RUBY="ruby18"
PATCHES=( "${FILESDIR}/${PN}-0.06-extconf.patch" )

src_compile() {
	ruby18 extconf.rb || die
	emake || die
}

src_install () {
	make install DESTDIR="${D}" || die
	dodoc README TODO
}
