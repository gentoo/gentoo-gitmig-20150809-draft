# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/adtool/adtool-1.2.ebuild,v 1.4 2004/07/15 03:46:08 agriffis Exp $

inherit eutils

DESCRIPTION="adtool is a Unix command line utility for Active Directory administration"
SRC_URI="http://c128.org/adtool/${P}.tar.gz"
HOMEPAGE="http://c128.org/adtool/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="net-nds/openldap
	dev-libs/openssl"
RDEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
