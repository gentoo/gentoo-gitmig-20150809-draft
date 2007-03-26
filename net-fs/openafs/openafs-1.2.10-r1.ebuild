# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.2.10-r1.ebuild,v 1.15 2007/03/26 08:15:01 antarus Exp $

inherit check-kernel fixheadtails eutils

DESCRIPTION="The AFS 3 scalable distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/openafs/${PV}/${P}-src.tar.bz2"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="-* x86"
IUSE=""

DEPEND="virtual/linux-sources
	>=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.75
	>=sys-apps/gawk-3.1.1"

SYS_NAME=i386_linux24


pkg_setup() {
	if is_2_5_kernel || is_2_6_kernel
	then
		die "OpenAFS does not yet support 2.5 and 2.6 kernels"
	fi
}


src_unpack() {
	unpack ${A}

	cd ${S}
	ht_fix_file "acinclude.m4"
	ht_fix_file "config.guess"
	ht_fix_file "src/afsd/afs.rc.linux"
	ht_fix_file "aclocal.m4"
	ht_fix_file "configure"
	ht_fix_file "configure-libafs"
	epatch ${FILESDIR}/openafs-pinstall-execve-1.2.10.patch
}

src_compile() {

	econf \
		--with-afs-sysname=i386_linux24 \
		--enable-transarc-paths || die

	make || die
}

src_install () {
	make dest || die

	# Client

	cd ${S}/${SYS_NAME}/dest/root.client/usr/vice

	insinto /etc/afs/modload
	doins etc/modload/*
	insinto /etc/afs/C
	doins etc/C/*

	insinto /etc/afs
	doins ${FILESDIR}/{ThisCell,CellServDB}
	doins etc/afs.conf

	mount -t afs | awk '{ exit $3 == "/afs" }' && keepdir /afs

	exeinto /etc/init.d
	newexe ${FILESDIR}/afs.rc.rc6 afs

	dosbin etc/afsd

	# Client Bin
	cd ${S}/${SYS_NAME}/dest
	exeinto /usr/afsws/bin
	doexe bin/*

	exeinto /etc/afs/afsws
	doexe etc/*

	cp -a include lib ${D}/usr/afsws
	dosym  /usr/afsws/lib/afs/libtermlib.a /usr/afsws/lib/afs/libnull.a

	# Server
	cd ${S}/${SYS_NAME}/dest/root.server/usr/afs
	exeinto /usr/afs/bin
	doexe bin/*

	dodir /usr/vice
	dosym /etc/afs /usr/vice/etc
	dosym /etc/afs/afsws /usr/afsws/etc

	dodoc ${FILESDIR}/README

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/afs/C /etc/afs/afsws"' \
		>> ${D}/etc/env.d/01${PN}
	echo 'PATH=/usr/afsws/bin:/etc/afs/afsws' \
		>> ${D}/etc/env.d/01${PN}
	echo 'ROOTPATH=/usr/afsws/bin:/etc/afs/afsws:/usr/afs/bin' \
		>> ${D}/etc/env.d/01${PN}
}

pkg_postinst () {
	einfo "UPDATE CellServDB and ThisCell to your needs !!"
	einfo "FOLLOW THE INSTRUCTIONS IN AFS QUICK BEGINNINGS"
	einfo "PAGE >45 TO DO INITIAL SERVER SETUP"
}
