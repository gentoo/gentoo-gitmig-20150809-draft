# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-2.1_p2.ebuild,v 1.2 2005/01/05 06:09:08 vapier Exp $

inherit toolchain-funcs

MY_PV=${PV/_p/-r}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 sparc ~x86"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/squashfs${PV/_p/-r}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_test() {
	./mksquashfs *.c *.h ${T}/squashfs \
		&& einfo "sucessfully created filesystem" \
		|| die "failed to create filesystem"
	if ! fgrep -q squashfs ${ROOT}/proc/filesystems ; then
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
