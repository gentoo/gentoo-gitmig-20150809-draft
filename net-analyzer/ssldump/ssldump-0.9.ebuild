# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssldump/ssldump-0.9.ebuild,v 1.4 2004/02/06 15:02:09 aliz Exp $

inherit gnuconfig

IUSE="ssl"

MY_P=${PN}-0.9b3
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.rtfm.com/ssldump/${MY_P}.tar.gz"
HOMEPAGE="http://www.rtfm.com/ssldump/"

SLOT="0"
KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"

DEPEND=">=net-libs/libpcap-0.6.1
	ssl? ( >=dev-libs/openssl-0.6.9 )"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-libpcap-header.patch
}

src_compile() {
	gnuconfig_update

	econf `use_with ssl crypto` || die
	emake || die
}

src_install() {
	into /usr
	dosbin ssldump
	doman ssldump.1
	dodoc COPYRIGHT CREDITS README FILES VERSION INSTALL ChangeLog
}
