# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/shfs/shfs-0.32.ebuild,v 1.4 2003/12/30 01:02:52 lu_zero Exp $

IUSE="amd doc"

DESCRIPTION="Secure Shell File System"
HOMEPAGE="http://shfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="virtual/linux-sources
		net-misc/openssh
		amd? ( net-fs/am-utils )"

src_unpack() {
	unpack ${A}
}

src_compile() {

	cd ${S}/shfsmount
	emake ROOT=${D} MODULESDIR=${D}/lib/modules/${KV} \
	KERNEL_SOURCES=/usr/src/linux || die

	if [ "`echo ${KV}|grep 2.6`" ] ; then
	cd ${S}/shfs/Linux-2.6/
	GENTOO_ARCH=${ARCH}
	unset ARCH
	addwrite "/usr/src/${FK}"
	export _POSIX2_VERSION=199209
	emake -j1 -C /usr/src/linux SUBDIRS="`pwd`" modules	|| die
	export ARCH=GENTOO_ARCH
	else
	cd ${S}/shfs/Linux-2.4/
	emake ROOT=${D} MODULESDIR=${D}/lib/modules/${KV} \
	KERNEL_SOURCES=/usr/src/linux || die
	fi

}

src_install() {
	# Install kernel module
	cd ${S}/shfs/Linux-`echo ${KV}|sed "s/^\([0-9]*\.[0-9]*\).*/\1/"`

	dodir /lib/modules/${KV}/kernel/fs/shfs/
	insinto /lib/modules/${KV}/kernel/fs/shfs/

	if [ "`echo ${KV}|grep 2.6`" ] ; then
	doins shfs.ko || die
	else
	doins shfs.o || die
	fi

# Install binaries
	cd ${S}/shfsmount
	dobin shfsmount
	dobin shfsumount

	# Allows users to mount/umount
	einfo " Setting suid bit on /usr/bin executables..."
	fperms 4511 /usr/bin/shfsmount
	fperms 4511 /usr/bin/shfsumount

	# Performs symlink to support use of mount(8)
	dodir /sbin
	einfo " Adding /sbin/mount.shfs symlink..."
	dosym /usr/bin/shfsmount /sbin/mount.shfs

	# Install docs
	doman ${S}/docs/manpages/shfsmount.8 ${S}/docs/manpages/shfsumount.8
	use doc && dohtml -r ${S}/docs/html

	# Install automount support (if desired)
	if [ -n "`use amd`" ] ; then
		einfo " Installing am-utils config files..."
		insinto /etc/amd
		doins ${FILESDIR}/amd.conf
		doins ${FILESDIR}/amd.shfs
		exeinto /etc/amd
		doexe ${FILESDIR}/shfs.mount
		dosym /etc/amd/shfs.mount /etc/amd/shfs.unmount
	fi
}

pkg_postinst() {
	echo "running depmod...."
	depmod -aq || die

	echo " "
	einfo " Use either 'shfsmount' or 'mount -t shfs' to mount remote"
	einfo " filesystems to into your local filesystem.               "
	echo " "
	echo " "
	einfo " Note the following:                                      "
	einfo "                                                          "
	einfo "   1.  The shfs kernel module has to be loaded first    "
	einfo "       before you can start mounting filesystems.         "
	einfo "       Try: 'modprobe shfs' as root.                        "
	einfo "                                                          "
	einfo "   2.  When mounting, you must enter the absolute path of "
	einfo "       the remote filesystem without any special chars,   "
	einfo "       such as tilde (~), for example.                    "
	echo " "
}
