# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.2.10-r2.ebuild,v 1.2 2004/01/13 10:11:20 mr_bones_ Exp $

inherit check-kernel fixheadtails flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="The AFS 3 scalable distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/openafs/${PV}/${P}-src.tar.bz2"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="~x86 ~alpha ~ia64"

DEPEND="virtual/linux-sources
	>=sys-apps/portage-2.0.47-r10
	>=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.75
	>=sys-apps/gawk-3.1.1"

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
	# The CC/MT_CC setting is required for link on alpha, and
	# recommended for link on x86 and other arches (even those that
	# don't technically require it).
	# http://marc.theaimsgroup.com/?l=gentoo-dev&m=107112691504786&w=2
	#
	# It's possible that CFLAGS could be added to MT_CC as well, but
	# I'm not experimenting here, just making it work on multiple
	# arches...  (12 Jan 2004 agriffis)
	econf --enable-transarc-paths || die econf
	make CC="${CC} -fPIC" MT_CC="${CC} -fPIC" || die make
}

src_install () {
	local sys_name=$(sed -n 's/^SYS_NAME=//p' Makefile) || die sys_name

	make dest || die dest

	# Client
	cd ${S}/${sys_name}/dest/root.client/usr/vice

	insinto /etc/afs/modload
	doins etc/modload/*
	insinto /etc/afs/C
	doins etc/C/*

	insinto /etc/afs
	doins ${FILESDIR}/{ThisCell,CellServDB}
	doins etc/afs.conf

	# Can't make this in src_install with keepdir because there might
	# be mounted afs filesystems at the time that this package is
	# installed/updated.  Can't test with mount because this might not
	# be the host where the package will be installed.  The best way
	# to do this is put it in pkg_* functions.  (12 Jan 2004 agriffis)
	#mount -t afs | awk '{ exit $3 == "/afs" }' && keepdir /afs

	exeinto /etc/init.d
	newexe ${FILESDIR}/afs.rc.rc6 afs

	dosbin etc/afsd

	# Client Bin
	cd ${S}/${sys_name}/dest
	exeinto /usr/afsws/bin
	doexe bin/*

	exeinto /etc/afs/afsws
	doexe etc/*

	cp -a include lib ${D}/usr/afsws
	dosym  /usr/afsws/lib/afs/libtermlib.a /usr/afsws/lib/afs/libnull.a

	# Server
	cd ${S}/${sys_name}/dest/root.server/usr/afs
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
	# See note in src_install regarding this
	mkdir /afs 2>/dev/null

	einfo
	einfo "UPDATE CellServDB and ThisCell to your needs !!"
	einfo "FOLLOW THE INSTRUCTIONS IN AFS QUICK BEGINNINGS"
	einfo "PAGE >45 TO DO INITIAL SERVER SETUP"
	einfo
}

pkg_preun () {
	# See note in src_install regarding this
	rmdir /afs 2>/dev/null
}
