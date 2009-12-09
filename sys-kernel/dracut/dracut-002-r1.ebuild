# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/dracut/dracut-002-r1.ebuild,v 1.1 2009/12/09 08:24:27 ramereth Exp $

EAPI=2

inherit eutils mount-boot

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="http://sourceforge.net/projects/dracut/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt dmraid iscsi lvm nbd nfs md selinux"

# common networking deps
NETWORK_DEPS="sys-apps/iproute2 net-misc/dhcp net-misc/bridge-utils"

RDEPEND="app-shells/dash
	>=sys-apps/module-init-tools-3.6
	>=sys-apps/util-linux-2.16
	crypt? ( sys-fs/cryptsetup )
	dmraid? ( sys-fs/dmraid )
	lvm? ( >=sys-fs/lvm2-2.02.33 )
	md? ( sys-fs/mdadm )
	nfs? ( net-fs/nfs-utils net-nds/rpcbind ${NETWORK_DEPS} )
	iscsi? ( sys-block/open-iscsi[utils] ${NETWORK_DEPS} )
	nbd? ( sys-block/nbd ${NETWORK_DEPS} )
	selinux? ( sys-libs/libselinux sys-libs/libsepol )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-unmount.patch"
	epatch "${FILESDIR}/${P}-custom-paths.patch"
	epatch "${FILESDIR}/${P}-dir-symlinks.patch"
	epatch "${FILESDIR}/${P}-add-missing-functions.patch"
	epatch "${FILESDIR}/${P}-gencmdline-check-for-keyboard-i18n-files.patch"
	epatch "${FILESDIR}/${P}-makefile-add-with_switch_root.patch"
}

src_compile() {
	emake WITH_SWITCH_ROOT=0 prefix=/usr sysconfdir=/etc || die "emake failed"
}

src_install() {
	local modules_dir="${D}/usr/share/dracut/modules.d"

	emake WITH_SWITCH_ROOT=0 \
		prefix=/usr sysconfdir=/etc \
		DESTDIR="${D}" install || die "emake install failed"
	echo "${PF}" > "${modules_dir}"/10rpmversion/dracut-version
	dodir /boot/dracut /var/lib/dracut/overlay
	dodoc HACKING TODO AUTHORS NEWS README*
	# disable modules not enabled by use flags
	for module in crypt dmraid lvm md ; do
		! use ${module} && rm -rf ${modules_dir}/90${module}
	done
	# disable all network modules
	for module in iscsi nbd nfs ; do
		! use ${module} && rm -rf ${modules_dir}/95${module}
	done
	# if no networking at all, disable the rest
	if ! use iscsi && ! use nbd && ! use nfs ; then
		rm -rf ${modules_dir}/40network
		rm -rf ${modules_dir}/95fcoe
	fi
}

pkg_postinst() {
	elog 'To generate the initramfs:'
	elog ' # mount /boot (if necessary)'
	elog ' # dracut "" <kernel-version>'
	elog ''
	elog 'For command line documentation, see:'
	elog 'http://sourceforge.net/apps/trac/dracut/wiki/commandline'
	elog ''
	elog 'Simple example to select root and resume partition:'
	elog ' root=/dev/???? resume=/dev/????'
	elog ''
	elog 'Configuration is in /etc/dracut.conf.'
	elog 'The default config is very minimal and is highly recommended you'
	elog 'adjust based on your needs. To include only drivers for this system,'
	elog 'use the "-H" option.'
}
