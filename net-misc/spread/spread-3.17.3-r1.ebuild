# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/spread-3.17.3-r1.ebuild,v 1.1 2006/10/06 12:48:29 caleb Exp $

inherit eutils

MY_PN="spread-src"

DESCRIPTION="Distributed network messaging system"
HOMEPAGE="http://www.spread.org"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.gz"

LICENSE="Spread-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"


pkg_setup()
{
	enewuser spread
	enewgroup spread
}

src_compile()
{
	econf || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die
	newinitd ${FILESDIR}/spread.init.d spread
	dodir /var/run/spread
}
