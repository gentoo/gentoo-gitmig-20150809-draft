# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dns/dns2go/dns2go-1.1-r2.ebuild,v 1.4 2002/08/14 12:10:49 murphy Exp $

S=${WORKDIR}/dns2go-1.1-1
DESCRIPTION="Dns2Go Linux Client v1.1"
SRC_URI="http://home.planetinternet.be/~felixdv/d2gsetup.tar.gz"
HOMEPAGE="http://www.dns2go.com"

SLOT="0"
LICENSE="DNS2GO"
KEYWORDS="x86 sparc sparc64"

DEPENDS="virtual/glibc"

src_install() {
    dobin dns2go
    doman dns2go.1 dns2go.conf.5
    dodoc INSTALL README LICENSE
    mkdir -p ${D}/var/dns2go
    mkdir -p ${D}/etc/init.d
    cp ${FILESDIR}/dns2go.rc6 ${D}/etc/init.d/dns2go
    chmod 755 ${D}/etc/init.d/dns2go
}
