# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quik/quik-2.0.1k.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $

inherit mount-boot

S="${WORKDIR}/"
MY_PV=${PV%.*}-${PV#*.*.}

HOMEPAGE=""
DESCRIPTION="OldWorld PowerMac Bootloader"
SRC_URI="http://www.xs4all.nl/~eddieb/linuxppc/YDL3/quik-${MY_PV}.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -alpha -sparc -mips"

DEPEND="virtual/glibc
        app-arch/rpm2targz"

PROVIDE="virtual/bootloader"

src_unpack() {
	cd ${WORKDIR}
    rpm2targz ${DISTDIR}/quik-${MY_PV}.src.rpm
    tar -xzf ${WORKDIR}/quik-${MY_PV}.src.tar.gz || die
    tar -xzf ${WORKDIR}/quik-2.0.tar.gz
    
    cd ${WORKDIR}/quik-2.0
    epatch ${WORKDIR}/quik_2.0e-0.1.diff
    epatch ${WORKDIR}/quik-glibc2.2.patch
    epatch ${WORKDIR}/quik-noargs.patch
    epatch ${WORKDIR}/quik-j-k-diff.patch
    epatch ${WORKDIR}/quik-k-dac.patch
}

src_compile() {
    cd ${WORKDIR}/quik-2.0
	emake || die
}

src_install() {
    cd ${WORKDIR}/quik-2.0
	DESTDIR=${D} make install
    prepman /usr
}
