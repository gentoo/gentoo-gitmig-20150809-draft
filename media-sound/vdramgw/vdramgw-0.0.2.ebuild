# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vdramgw/vdramgw-0.0.2.ebuild,v 1.5 2010/08/13 21:31:17 hwoarang Exp $

inherit eutils toolchain-funcs

MY_P=vdr-amarok-${PV}

DESCRIPTION="vdr to amarok gateway - allows vdr-amarok to access amarok"
HOMEPAGE="http://irimi.ir.ohost.de/"
SRC_URI="http://irimi.ir.ohost.de/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P#vdr-}/${PN}"
RDEPEND="media-sound/amarok"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc43.patch
	# Respect CC,CXXFLAGS, LDFLAGS
	sed -i -e "/^CXX /s:?=.*:= $(tc-getCXX):" \
		-e "/^CXXFLAGS/s:?=.*:= ${CFLAGS}:" \
		-e "s:\$(CXXFLAGS):& \$(LDFLAGS) :" "${S}"/Makefile
}

src_install() {
	dobin ${PN}
	dodoc README
	newdoc ../README README.vdr-amarok

	insinto /etc
	doins ${PN}.conf
}
