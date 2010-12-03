# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/adtool/adtool-1.3.2.ebuild,v 1.2 2010/12/03 01:01:39 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="adtool is a Unix command line utility for Active Directory administration"
SRC_URI="http://gp2x.org/adtool/${P}.tar.gz"
HOMEPAGE="http://gp2x.org/adtool/"

KEYWORDS="~amd64 ~ppc ~x86"
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

	eautoreconf
}

src_install() {
	einstall || die "einstall failed"
}
