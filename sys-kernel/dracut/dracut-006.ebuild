# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/dracut/dracut-006.ebuild,v 1.3 2011/03/21 12:39:04 aidecoe Exp $

EAPI=2

inherit eutils mount-boot

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="http://dracut.wiki.kernel.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="btrfs crypt dmraid iscsi lvm multipath nbd nfs md selinux uswsusp xen"
RESTRICT="test"

# common networking deps
NETWORK_DEPS="sys-apps/iproute2 net-misc/dhcp net-misc/bridge-utils"

RDEPEND="app-shells/dash
	sys-apps/module-init-tools
	>=sys-apps/util-linux-2.16
	btrfs? ( sys-fs/btrfs-progs )
	crypt? ( sys-fs/cryptsetup )
	dmraid? ( sys-fs/dmraid sys-fs/multipath-tools )
	lvm? ( >=sys-fs/lvm2-2.02.33 )
	md? ( sys-fs/mdadm )
	nfs? ( net-fs/nfs-utils net-nds/rpcbind ${NETWORK_DEPS} )
	iscsi? ( sys-block/open-iscsi[utils] ${NETWORK_DEPS} )
	multipath? ( sys-fs/multipath-tools )
	nbd? ( sys-block/nbd ${NETWORK_DEPS} )
	selinux? ( sys-libs/libselinux sys-libs/libsepol )
	uswsusp? ( sys-power/suspend )
	xen? ( app-emulation/xen )
	"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-dhcp6.patch"
	epatch "${FILESDIR}/${P}-lc-all-c.patch"
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
	for module in btrfs crypt dmraid lvm md multipath uswsusp xen ; do
		! use ${module} && rm -rf ${modules_dir}/90${module}
	done
	# disable all network modules
	for module in iscsi nbd nfs ; do
		! use ${module} && rm -rf ${modules_dir}/95${module}
	done
	# if no networking at all, disable the rest
	if ! use iscsi && ! use nbd && ! use nfs ; then
		rm -rf ${modules_dir}/40network
	fi
	# disable modules which won't work for sure
	rm -rf ${modules_dir}/01fips
	rm -rf ${modules_dir}/10redhat-i18n
	rm -rf ${modules_dir}/95fcoe
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
