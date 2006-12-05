# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/quik/quik-2.1.6.ebuild,v 1.3 2006/12/05 04:51:38 josejx Exp $

inherit toolchain-funcs mount-boot eutils

MY_PV=${PV%.*}-${PV#*.*.}

HOMEPAGE="http://penguinppc.org/bootloaders/quik/"
DESCRIPTION="OldWorld PowerMac Bootloader"
SRC_URI="http://www.shiner.info/files/Yellow%20Dog%20Linux%204/quik/quik-${MY_PV}.ydl4.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ppc"
IUSE=""

DEPEND="virtual/libc
	app-arch/rpm2targz"

PROVIDE="virtual/bootloader"

S="${WORKDIR}/"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/quik-${MY_PV}.ydl4.src.rpm
	tar -xzf ${WORKDIR}/quik-${MY_PV}.ydl4.src.tar.gz || die
	tar -xzf ${WORKDIR}/quik_2.1.orig.tar.gz

	cd ${WORKDIR}/quik-2.1
	epatch ${WORKDIR}/quik_2.1-6.diff.gz
	epatch ${FILESDIR}/md-fix.diff
	epatch ${FILESDIR}/headers.patch
}

src_compile() {
	cd ${WORKDIR}/quik-2.1
	emake || die
}

src_install() {
	cd ${WORKDIR}/quik-2.1
	DESTDIR=${D} make install
	prepman /usr
}
