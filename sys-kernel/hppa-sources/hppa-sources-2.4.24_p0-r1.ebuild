# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.4.24_p0-r1.ebuild,v 1.1 2004/02/18 22:06:19 plasmaroo Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
EXTRAVERSION="-pa${PATCH_LEVEL}"
[ ! "${PR}" = "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}
IUSE="xfs"

PATCH_SET="`seq 0 ${PATCH_LEVEL}`"
PATCH_COUNT="$(( `echo ${PATCH_SET} | wc -w` - 1 ))"


DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz
xfs? ( http://dev.gentoo.org/~gmsoft/patches/xfs-2.4.23_p4-hppa.patch.bz2 )
http://dev.gentoo.org/~gmsoft/patches/parisc-2.4.23-pa4-missing-ioctl-translations.diff"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`
	zcat ${DISTDIR}/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz | patch -sp 1

	use xfs && epatch ${DISTDIR}/xfs-2.4.23_p4-hppa.patch.bz2

	DEFCONFIG="${S}/arch/parisc/defconfig"

	# Tweaks the default configuration

	# Enable stuff
	for i in CONFIG_SERIAL_NONSTANDARD CONFIG_PDC_CONSOLE CONFIG_DEVFS_FS \
		CONFIG_USB CONFIG_USB_OHCI CONFIG_USB_HID CONFIG_USB_HIDINPUT \
		CONFIG_CRC32 CONFIG_BLK_STATS CONFIG_TMPFS
	do
		sed -i -e "s/^.*${i}\ .*$//" "${DEFCONFIG}"
		echo "${i}=y" >> "${DEFCONFIG}"
	done

	# Disable stuff
	for i in CONFIG_HOTPLUG CONFIG_PARPORT CONFIG_BLK_DEV_RAM CONFIG_MD \
		CONFIG_CRYPTO CONFIG_DEVPTS_FS
	do
		sed -i -e "s/^.*${i}=.*$/# ${i} is not set/" "${DEFCONFIG}"
	done

	epatch ${DISTDIR}/parisc-2.4.23-pa4-missing-ioctl-translations.diff || die "Failed to patch missing ioctls translations!"
	epatch ${FILESDIR}/${PN}.munmap.patch || die "Failed to apply munmap patch!"

	kernel_universal_unpack
}
