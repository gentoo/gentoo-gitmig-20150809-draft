# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/f-prot/f-prot-3.12a.ebuild,v 1.2 2002/07/17 04:20:40 seemant Exp $

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
SRC_URI="ftp://ftp.f-prot.com/pub/${MY_P}.tar.gz"

# unzip and wget are needed for the check-updates.sh script
RDEPEND=">=app-arch/unzip-5.42-r1
	>=net-misc/wget-1.8.2"

SLOT="0"
LICENSE="F-PROT"
KEYWORDS="x86"

src_compile () {
    echo "Nothing to compile."
}

src_install () {
    doman f-prot.8
    dodoc LICENSE CHANGES INSTALL README

    dodir /opt/f-prot
    insinto /opt/f-prot
    insopts -m 755
    doins f-prot f-prot.sh check-updates.sh checksum
    insopts -m 644
    doins *.DEF ENGLISH.TX0
}
