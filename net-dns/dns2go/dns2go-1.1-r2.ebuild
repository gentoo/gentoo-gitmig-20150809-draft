# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dns2go/dns2go-1.1-r2.ebuild,v 1.16 2004/07/14 23:23:34 agriffis Exp $

DESCRIPTION="Dns2Go Linux Client v1.1"
HOMEPAGE="http://www.dns2go.com/"
SRC_URI="http://home.planetinternet.be/~felixdv/d2gsetup.tar.gz"

LICENSE="DNS2GO"
SLOT="0"
KEYWORDS="x86 amd64 -* s390"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${P}-1

src_install() {
	dobin dns2go
	doman dns2go.1 dns2go.conf.5
	dodoc INSTALL README LICENSE

	keepdir /var/dns2go

	exeinto /etc/init.d
	newexe ${FILESDIR}/dns2go.rc6 dns2go
}
