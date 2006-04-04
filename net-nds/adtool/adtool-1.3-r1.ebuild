# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/adtool/adtool-1.3-r1.ebuild,v 1.1 2006/04/04 14:30:42 satya Exp $

inherit eutils

DESCRIPTION="adtool is a Unix command line utility for Active Directory administration"
SRC_URI="http://c128.org/adtool/${P}.tar.gz"
HOMEPAGE="http://c128.org/adtool/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="ssl"

DEPEND="net-nds/openldap
	ssl?    ( dev-libs/openssl )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/adtool-1.3-10-asneeded.patch
}
src_compile() {
	econf || die
	emake || die
}
src_install() {
	einstall || die
}
