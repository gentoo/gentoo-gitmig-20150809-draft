# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.4.23_p4-r1.ebuild,v 1.2 2003/12/31 15:09:10 gmsoft Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
KV=${OKV}-pa${PATCH_LEVEL}
EXTRAVERSION="-pa${PATCH_LEVEL}"
S=${WORKDIR}/linux-${KV}
IUSE="xfs"

PATCH_SET="`seq 1 ${PATCH_LEVEL}`"
PATCH_COUNT="$(( `echo ${PATCH_SET} | wc -w` - 1 ))"


DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz
`for i in \`seq 1 ${PATCH_COUNT}\`; do echo http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa\`echo ${PATCH_SET} | awk \"{ print \\\\\$$i }\"\`-pa\`echo ${PATCH_SET} | awk \"{ print \\\\\$$((i + 1)) }\"\`.gz; done`
xfs? ( http://dev.gentoo.org/~gmsoft/patches/xfs-${PV}-hppa.patch.bz2 )"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="~hppa -*"
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`
	zcat ${DISTDIR}/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz | patch -sp 1

	for i in `seq 1 ${PATCH_COUNT}`
	do
		a=`echo ${PATCH_SET} | awk "{ print \\\$$i }"`
		b=`echo ${PATCH_SET} | awk "{ print \\\$$((i + 1)) }"`
		einfo Applying patch from ${OKV}-pa${a} to ${OKV}-pa${b}
		zcat ${DISTDIR}/patch-${OKV}-pa${a}-pa${b}.gz | patch -sp 1
	done

	use xfs && epatch ${DISTDIR}/xfs-${PV}-hppa.patch.bz2

	#Fix Rule.make
	sed -i Rules.make \
		-e '/LD.*-r.*$/s/-r/$(LINKFLAGS) -r/'

	DEFCONFIG="${S}/arch/parisc/defconfig"

	# Tweaks the default configuration

	for i in CONFIG_SERIAL_NONSTANDARD CONFIG_PDC_CONSOLE CONFIG_DEVFS_FS \
		CONFIG_USB CONFIG_USB_OHCI CONFIG_USB_HID CONFIG_USB_HIDINPUT \
		CONFIG_CRC32 CONFIG_BLK_STATS
	do
		sed -i -e "s/^.*${i}\ .*$//" "${DEFCONFIG}"
		echo "${i}=y" >> "${DEFCONFIG}"
	done

	for i in CONFIG_HOTPLUG CONFIG_PARPORT CONFIG_BLK_DEV_RAM CONFIG_MD \
		CONFIG_CRYPTO CONFIG_DEVPTS_FS
	do
		sed -i -e "s/^.*${i}=.*$/# ${i} is not set/" "${DEFCONFIG}"
	done

	kernel_universal_unpack
}
