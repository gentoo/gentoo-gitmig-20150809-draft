# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/shfs/shfs-0.31.ebuild,v 1.2 2003/06/12 21:25:29 msterret Exp $

IUSE="amd doc"

MY_P=${P}-1
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure Shell File System"
HOMEPAGE="http://shfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
DEPEND="virtual/linux-sources
		net-misc/openssh
		amd? ( net-fs/am-utils )"

src_compile() {
	epatch ${FILESDIR}/shfs-gentoo-${PV}-makefile-root.diff
	use ppc && epatch ${FILESDIR}/shfs-gentoo-${PV}-ppc.diff
	emake || die
}

src_install() {
	# Install kernel module
	cd ${S}/shfs
	mv Makefile Makefile.old
	cat Makefile.old | grep -v depmod > Makefile
	einfo " Installing kernel module..."
	make MODULESDIR=${D}/lib/modules/${KV} install || die
	
	# Install binaries
	cd ${S}/shfsmount
	dobin shfsmount
	dobin shfsumount

	# Allows users to mount/umount
	einfo " Setting suid bit on /usr/bin executables..."
	fperms 4755 /usr/bin/shfsmount
	fperms 4755 /usr/bin/shfsumount

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
}
