# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssldump/ssldump-0.9.ebuild,v 1.1 2003/05/19 21:36:26 mholzer Exp $

IUSE="ssl"

MY_P=${PN}-0.9b3
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.rtfm.com/ssldump/${MY_P}.tar.gz"
HOMEPAGE="http://www.rtfm.com/ssldump/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND=">=net-libs/libpcap-0.6.1
	ssl? ( >=dev-libs/openssl-0.6.9 )"


src_compile() {
	local myconf

	use ssl || myconf="--without-crypto"
	econf ${myconf} || die
	emake || die
}

src_install() {															 
	into /usr
	dosbin ssldump
	doman ssldump.1
	dodoc COPYRIGHT CREDITS README FILES VERSION INSTALL ChangeLog
}
