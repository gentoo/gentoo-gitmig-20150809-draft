# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-2.0_p2.ebuild,v 1.1 2004/09/07 05:19:03 dragonheart Exp $


MY_PV=${PV/_p/-r}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~ppc64"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	>=sys-apps/sed-4"

RDEPEND="virtual/libc
	sys-libs/zlib"

S=${WORKDIR}/squashfs${PV/_p/r}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_test() {
	./mksquashfs *.c *.h ${T}/squashfs && einfo "sucessfully created filesystem" \
		|| die "failed to create filesystem"
	if ! fgrep -q squashfs ${ROOT}/proc/filesystems;
	then
		modprobe squashfs || ewarn "no squashfs modules - test not completed"
		touch ${T}/modprobe
		fgrep -q squashfs ${ROOT}/proc/filesystems || \
			ewarn "no squashfs failsystem available in this kernel - tests not completed"
	fi

	if hasq userpriv ${FEATURES};
	then
		ewarn "FEATURES userpriv hinders testing. Restricts the ability to mount filesystems."
		ewarn "Further testing skipped"
	else
		if fgrep -q squashfs ${ROOT}/proc/filesystems;
		then
			mkdir ${T}/squashfs_dir
			mount -n -o loop,ro ${T}/squashfs ${T}/squashfs_dir -t squashfs || die  "mount failed"

			diff squashfs_fs.h ${T}/squashfs_dir/squashfs_fs.h && einfo "test suceeded" \
				|| die "test failed"
		fi
		umount ${T}/squashfs_dir
	fi

	# clean up

	if [ -f ${T}/modprobe ];
	then
		rmmod squashfs
	fi
}

src_install() {
	dobin mksquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES README-2.0 README-AMD64
}
