# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-tools/s390-tools-1.3.0.ebuild,v 1.5 2004/07/15 02:32:09 agriffis Exp $

inherit eutils

STREAM="april2004"

KERNEL_VERSION=2.4.19
BBOX_VERSION=0.60.5
E2FS_PROGS_VERSION=1.32

DESCRIPTION="A set of user space utilities that should be used together with the zSeries (s390) Linux kernel and device drivers"
# must be downloaded from IBM
SRC_URI="mirror://gentoo/${PN}-${PV}-${STREAM}.tar.gz
	http://www.busybox.net/downloads/busybox-${BBOX_VERSION}.tar.bz2
	mirror://sourceforge/e2fsprogs/e2fsprogs-${E2FS_PROGS_VERSION}.tar.gz
	http://www.kernel.org/pub/linux/kernel/v2.4/linux-${KERNEL_VERSION}.tar.bz2"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/linux390/april2004_recommended.shtml"
LICENSE="GPL-2"
KEYWORDS="~s390"
IUSE=""
SLOT="0"
DEPEND="virtual/libc
	net-analyzer/ucd-snmp
	app-admin/genromfs
	dev-util/indent"

PROVIDE="virtual/bootloader"

src_unpack() {
	unpack "${PN}-${PV}-${STREAM}.tar.gz"
	for tarball in busybox-${BBOX_VERSION}.tar.bz2 \
			e2fsprogs-${E2FS_PROGS_VERSION}.tar.gz \
			linux-${KERNEL_VERSION}.tar.bz2 ; do
		cp ${DISTDIR}/$tarball ${S}/zfcpdump/extern
	done
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall INSTROOT=${D}
	prepall
}
