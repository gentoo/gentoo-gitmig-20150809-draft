# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dns2go/dns2go-1.1-r1.ebuild,v 1.2 2001/11/19 21:41:12 verwilst Exp $

S=${WORKDIR}/dns2go-1.1-1
DESCRIPTION="Dns2Go Linux Client v1.1"
SRC_URI="http://home.planetinternet.be/~felixdv/d2gsetup.tar.gz"
#ftp://ftp2.deerfield.com/pub/dns2go/linux/d2gsetup(linux).tar.gz
HOMEPAGE="http://www.dns2go.com"

DEPENDS="virtual/glibc"

src_install() {
    dobin dns2go
    doman dns2go.1 dns2go.conf.5
    dodoc INSTALL README LICENSE
}
