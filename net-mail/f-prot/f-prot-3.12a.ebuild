# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/f-prot/f-prot-3.12a.ebuild,v 1.1 2002/06/10 21:06:25 g2boojum Exp $

DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"

# unzip and wget are needed for the check-updates.sh script
DEPEND=""
RDEPEND="virtual/glibc
         >=app-arch/unzip-5.42-r1
         >=net-misc/wget-1.8.2"

A="f-prot_3.12a.tar.gz"
SRC_URI="ftp://ftp.f-prot.com/pub/${A}"

S="${WORKDIR}/f-prot_3.12a"

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
