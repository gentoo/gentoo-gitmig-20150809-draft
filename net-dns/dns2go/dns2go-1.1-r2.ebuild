# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dns2go/dns2go-1.1-r2.ebuild,v 1.8 2003/02/13 13:57:21 vapier Exp $

S=${WORKDIR}/${P}-1
DESCRIPTION="Dns2Go Linux Client v1.1"
SRC_URI="http://home.planetinternet.be/~felixdv/d2gsetup.tar.gz"
HOMEPAGE="http://www.dns2go.com"

SLOT="0"
LICENSE="DNS2GO"
KEYWORDS="x86 sparc "

DEPENDS="virtual/glibc"

src_install() {
	dobin dns2go
	doman dns2go.1 dns2go.conf.5
	dodoc INSTALL README LICENSE

	touch ${S}/.keep
	insinto /var/dns2go
	doins .keep

	exeinto /etc/init.d
	newexe ${FILESDIR}/dns2go.rc6 dns2go
}
