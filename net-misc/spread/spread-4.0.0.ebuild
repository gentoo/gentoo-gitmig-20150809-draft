# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/spread-4.0.0.ebuild,v 1.1 2007/03/22 12:14:43 armin76 Exp $

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# don't strip binaries
	sed -i -e 's/0755 -s/0755/g' daemon/Makefile.in examples/Makefile.in
}

src_install() {
	emake DESTDIR=${D} install || die
	newinitd ${FILESDIR}/spread.init.d spread
	dodir /var/run/spread
}
