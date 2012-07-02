# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mkinitcpio/mkinitcpio-0.9.2.ebuild,v 1.2 2012/07/02 12:58:33 xmw Exp $

EAPI=3
inherit eutils linux-info

DESCRIPTION="Modular initramfs image creation utility ported from Arch Linux"
HOMEPAGE="http://www.archlinux.org/"
MY_SRC_URI_CORE="ftp://ftp.archlinux.org/core/os/x86_64"
SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${P}.tar.gz
	udev? ( ${MY_SRC_URI_CORE}/systemd-tools-185-4-x86_64.pkg.tar.xz )
	device-mapper? ( ${MY_SRC_URI_CORE}/device-mapper-2.02.96-2-x86_64.pkg.tar.xz
		${MY_SRC_URI_CORE}/lvm2-2.02.96-2-x86_64.pkg.tar.xz )
	cryptsetup? ( ${MY_SRC_URI_CORE}/cryptsetup-1.4.3-1-x86_64.pkg.tar.xz )
	mdadm? ( ${MY_SRC_URI_CORE}/mdadm-3.2.5-2-x86_64.pkg.tar.xz )
	dmraid? ( ${MY_SRC_URI_CORE}/dmraid-1.0.0.rc16.3-7-x86_64.pkg.tar.xz )
	pcmcia? ( ${MY_SRC_URI_CORE}/pcmciautils-018-4-x86_64.pkg.tar.xz )
	plymouth? ( http://aur.archlinux.org/packages/pl/plymouth-git/plymouth-git.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cryptsetup device-mapper dmraid mdadm pcmcia plymouth udev"

DEPEND="sys-apps/sed"
RDEPEND="app-arch/cpio
	app-arch/gzip
	app-arch/libarchive
	app-shells/bash
	>=sys-apps/busybox-1.20[static]
	sys-apps/coreutils
	sys-apps/file
	sys-apps/findutils
	sys-apps/grep
	>=sys-apps/kmod-7
	>=sys-apps/util-linux-2.21
	udev? ( >sys-fs/udev-171-r6 )
	device-mapper? ( sys-fs/lvm2[static] )
	cryptsetup? ( sys-fs/cryptsetup[static] )
	mdadm? ( sys-fs/mdadm[static] )
	dmraid? ( sys-fs/dmraid[static] )
	pcmcia? ( sys-apps/pcmciautils[static] )
	plymouth? ( sys-boot/plymouth )"

pkg_setup() {
	if kernel_is -lt 2 6 32 ; then
		eerror "Sorry, your kernel must be 2.6.32-r103 or newer!"
	fi

	use udev && CONFIG_CHECK+=" ~DEVTMPFS"
	use mdadm && CONFIG_CHECK+=" ~MD ~MD_LINEAR ~MD_RAID0 ~MD_RAID1 ~MD_RAID10 ~MD_RAID456"
	use dmraid && CONFIG_CHECK+=" ~BLK_DEV_DM ~DM_SNAPSHOT ~DM_MIRROR ~DM_RAID ~DM_UEVENT"
	use device-mapper && CONFIG_CHECK+=" ~BLK_DEV_DM ~DM_SNAPSHOT ~DM_UEVENT"
	use cryptsetup && CONFIG_CHECK+=" ~DM_CRYPT"

	linux-info_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-base-install.patch
	epatch "${FILESDIR}"/${PN}-consolefont-install.patch
	epatch "${FILESDIR}"/${PN}-keymap-install.patch
	cd "${WORKDIR}"
	use udev && epatch "${FILESDIR}"/${PN}-udev-install.patch
	use device-mapper && epatch "${FILESDIR}"/${PN}-lvm2-install.patch
	use mdadm epatch "${FILESDIR}"/${PN}-mdadm_udev-install.patch
	use dmraid && epatch "${FILESDIR}"/${PN}-dmraid-install.patch
	use pcmcia && epatch "${FILESDIR}"/${PN}-pcmcia-install.patch
	use cryptsetup && epatch "${FILESDIR}"/${PN}-encrypt-install.patch
}

src_install() {
	emake DESTDIR="${D}" install

	cd  "${WORKDIR}/usr/lib/initcpio/hooks"
	insinto /usr/lib/initcpio/hooks/
	use udev && doins udev
	use device-mapper && doins lvm2
	if use mdadm ; then
		doins mdadm
		dosym mdadm /usr/lib/initcpio/hooks/raid
	fi
	use dmraid && doins dmraid
	use cryptsetup && doins encrypt
	use plymouth && newins "${WORKDIR}"/plymouth-git/plymouth.initcpio_hook pylmouth

	cd "${WORKDIR}/usr/lib/initcpio/install"
	insinto /usr/lib/initcpio/install
	use udev && doins udev
	use device-mapper && doins lvm2
	use mdadm && doins mdadm mdadm_udev
	use dmraid && doins dmraid
	use cryptsetup && doins encrypt
	use pcmcia && doins pcmcia
	use plymouth && newins "${WORKDIR}"/plymouth-git/plymouth.initcpio_install pylmouth

	if use device-mapper; then
		if use udev; then
			insinto /usr/lib/initcpio/udev/
			doins "${WORKDIR}/usr/lib/initcpio/udev/11-dm-initramfs.rules"
		fi
	fi

	dodir /etc/mkinitcpio.d
	newins "${FILESDIR}"/gentoo.preset ${KV}.preset
	sed -e "s/KV/${KV}/g" \
		"${FILESDIR}"/gentoo.preset \
		> "${D}"/etc/mkinitcpio.d/${KV}.preset || die

	insinto /usr/lib/modprobe.d
	doins "${FILESDIR}/usb-load-ehci-first.conf"
}

pkg_postinst() {
	einfo
	elog "Set your hooks in /etc/mkinitcpio.conf accordingly!"
	elog "Missing hooks can lead to an unbootanle system!"
	einfo
}
