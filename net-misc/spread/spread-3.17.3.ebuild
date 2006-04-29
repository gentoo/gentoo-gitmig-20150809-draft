# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/spread-3.17.3.ebuild,v 1.3 2006/04/29 20:52:11 caleb Exp $

inherit eutils

MY_PN="spread-src"

DESCRIPTION="Distributed network messaging system"
HOMEPAGE="http://www.spread.org"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.gz"

LICENSE="Spread-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${MY_PN}-${PV}"


src_compile()
{
	econf || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst()
{
	dodir /var/run/spread
	enewuser spread
	enewgroup spread
}
