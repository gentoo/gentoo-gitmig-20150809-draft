# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.4.27_p4-r1.ebuild,v 1.1 2004/11/24 17:04:12 gmsoft Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
EXTRAVERSION="-pa${PATCH_LEVEL}"
[ ! "${PR}" = "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}


DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa${PATCH_LEVEL}.gz
http://dev.gentoo.org/~gmsoft/patches/parisc-2.4.23-pa4-missing-ioctl-translations.diff http://dev.gentoo.org/~gmsoft/patches/lasi-config-max-tag-queue-dep.patch"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
IUSE=""
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa${PATCH_LEVEL}.gz
	zcat ${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz | patch -sp 1

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
	epatch ${DISTDIR}/lasi-config-max-tag-queue-dep.patch || die "Failed to patch lasi config max taq queue!"
	epatch ${FILESDIR}/NFS-XDR-security.patch || die "Patch failed!"
	epatch ${FILESDIR}/CAN-2004-0814.patch || die "Patch failed!"
	epatch ${FILESDIR}/binfmt_elf-loader-security.patch || die "Patch failed!"
	epatch ${FILESDIR}/CAN-2004-0882-0883.patch || die "Patch failed!"
	epatch ${FILESDIR}/AF_UNIX-security.patch || die "Patch failed!"

	kernel_universal_unpack
}
