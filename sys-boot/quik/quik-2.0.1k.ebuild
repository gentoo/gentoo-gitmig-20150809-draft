# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/quik/quik-2.0.1k.ebuild,v 1.7 2004/11/06 03:57:54 dragonheart Exp $

inherit toolchain-funcs mount-boot eutils

S="${WORKDIR}/"
MY_PV=${PV%.*}-${PV#*.*.}

HOMEPAGE=""
DESCRIPTION="OldWorld PowerMac Bootloader"
SRC_URI="http://www.xs4all.nl/~eddieb/linuxppc/YDL3/quik-${MY_PV}.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc -x86 -amd64 -alpha -hppa -mips -sparc"
IUSE=""

DEPEND="virtual/libc
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
