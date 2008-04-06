# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/adtool/adtool-1.3-r1.ebuild,v 1.4 2008/04/06 14:31:16 dertobi123 Exp $

WANT_AUTOMAKE="1.7"

inherit eutils autotools

DESCRIPTION="adtool is a Unix command line utility for Active Directory administration"
SRC_URI="http://gp2x.org/adtool/${P}.tar.gz"
HOMEPAGE="http://gp2x.org/adtool/"

KEYWORDS="ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="ssl"

DEPEND="net-nds/openldap
	ssl?    ( dev-libs/openssl )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/adtool-1.3-10-asneeded.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
