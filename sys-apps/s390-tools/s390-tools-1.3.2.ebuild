# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-tools/s390-tools-1.3.2.ebuild,v 1.2 2004/10/29 22:10:32 vapier Exp $

inherit eutils

STREAM="april2004"
KERNEL="linux-2.6.5"
BBOX="busybox-0.60.5"
E2FS_PROGS="e2fsprogs-1.35"

DESCRIPTION="A set of user space utilities that should be used together with the zSeries (s390) Linux kernel and device drivers"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/linux390/april2004_recommended.shtml"
SRC_URI="mirror://gentoo/${PN}-${PV}-${STREAM}.tar.gz
	http://www.busybox.net/downloads/${BBOX}.tar.bz2
	mirror://sourceforge/e2fsprogs/${E2FS_PROGS}.tar.gz
	mirror://kernel/linux/kernel/v2.6/${KERNEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="s390"
IUSE=""

DEPEND="virtual/libc
	virtual/snmp
	app-admin/genromfs
	dev-util/indent"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack "${PN}-${PV}-${STREAM}.tar.gz"
	FILES="${BBOX}.tar.bz2 ${E2FS_PROGS}.tar.gz ${KERNEL}.tar.bz2"
	for x in ${FILES}; do
		cp ${DISTDIR}/$x ${S}/zfcpdump/extern
	done
	sed -i -e "s:-lrpm[iodb]*::g" ${S}/osasnmpd/Makefile.rules
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall INSTROOT="${D}" USRBINDIR="${D}/sbin" || die
	prepall
}
