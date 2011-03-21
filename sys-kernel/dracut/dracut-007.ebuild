# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/dracut/dracut-007.ebuild,v 1.7 2011/03/21 12:39:05 aidecoe Exp $

EAPI=2

inherit eutils

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="http://dracut.wiki.kernel.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_IUSE="bootchart btrfs debug gensplash mdraid multipath selinux syslog
uswsusp xen"
NETWORK_IUSE="iscsi nbd nfs"
DM_IUSE="crypt dmraid dmsquash-live lvm"
IUSE="${COMMON_IUSE} ${DM_IUSE} ${NETWORK_IUSE}"
RESTRICT="test"

NETWORK_DEPS="net-misc/bridge-utils >=net-misc/dhcp-3.1.2_p1 sys-apps/iproute2"
DM_DEPS="|| ( sys-fs/device-mapper >=sys-fs/lvm2-2.02.33 )"

RDEPEND="
	>=app-shells/bash-4.0
	>=app-shells/dash-0.5.4.11
	>=sys-apps/baselayout-1.12.14-r1
	>=sys-apps/module-init-tools-3.5
	>=sys-apps/sysvinit-2.87-r3
	>=sys-apps/util-linux-2.16
	>=sys-fs/udev-149

	bootchart? ( app-benchmarks/bootchart )
	btrfs? ( sys-fs/btrfs-progs )
	crypt? ( sys-fs/cryptsetup ${DM_DEPS} )
	debug? ( dev-util/strace )
	dmraid? ( sys-fs/dmraid sys-fs/multipath-tools ${DM_DEPS} )
	dmsquash-live? ( sys-apps/eject ${DM_DEPS} )
	gensplash? ( media-gfx/splashutils )
	iscsi? ( sys-block/open-iscsi[utils] ${NETWORK_DEPS} )
	lvm? ( >=sys-fs/lvm2-2.02.33 )
	mdraid? ( sys-fs/mdadm )
	multipath? ( sys-fs/multipath-tools )
	nbd? ( sys-block/nbd ${NETWORK_DEPS} )
	nfs? ( net-fs/nfs-utils net-nds/rpcbind ${NETWORK_DEPS} )
	selinux? ( sys-libs/libselinux sys-libs/libsepol )
	syslog? ( || ( app-admin/syslog-ng app-admin/rsyslog ) )
	uswsusp? ( sys-power/suspend )
	xen? ( app-emulation/xen )
	"
DEPEND="
	>=dev-libs/libxslt-1.1.26
	app-text/docbook-xml-dtd:4.5
	>=app-text/docbook-xsl-stylesheets-1.75.2
	"

#
# Helper functions
#

# Returns true if any of specified modules is enabled by USE flag and false
# otherwise.
# $1 = list of modules (which have corresponding USE flags of the same name)
any_module() {
	local m modules=" $@ "

	for m in ${modules}; do
		! use $m && modules=${modules/ $m / }
	done

	shopt -s extglob
	modules=${modules%%+( )}
	shopt -u extglob

	[[ ${modules} ]]
}

# Removes module from modules.d.
# $1 = module name
# Module name can be specified without number prefix.
rm_module() {
	local m

	for m in $@; do
		if [[ $m =~ ^[0-9][0-9][^\ ]*$ ]]; then
			rm -rf "${modules_dir}"/$m
		else
			rm -rf "${modules_dir}"/[0-9][0-9]$m
		fi
	done
}

# Displays Gentoo Base System major release number
base_sys_maj_ver() {
	local line

	read line < /etc/gentoo-release
	line=${line##* }
	echo "${line%%.*}"
}

#
# ebuild functions
#

src_prepare() {
	epatch "${FILESDIR}/${P}-multipath-udev-rules.patch"
	epatch "${FILESDIR}/${P}-dm-udev-rules.patch"
}

src_compile() {
	emake WITH_SWITCH_ROOT=0 || die "emake failed"
}

src_install() {
	emake WITH_SWITCH_ROOT=0 \
		prefix=/usr sysconfdir=/etc DESTDIR="${D}" \
		install || die "emake install failed"

	local gen2conf

	dodir /var/lib/dracut/overlay
	dodoc HACKING TODO AUTHORS NEWS README* || die 'dodoc failed'

	case "$(base_sys_maj_ver)" in
		1) gen2conf=gentoo.conf ;;
		2) gen2conf=gentoo-openrc.conf ;;
		*) die "Expected ver. 1 or 2 of Gentoo Base System (/etc/gentoo-release)."
	esac

	insinto /etc/dracut.conf.d
	newins dracut.conf.d/${gen2conf}.example ${gen2conf} \
		|| die 'gen2conf ins failed'

	#
	# Modules
	#
	local module
	modules_dir="${D}/usr/share/dracut/modules.d"

	echo "${PF}" > "${modules_dir}"/10rpmversion/dracut-version \
		|| die 'dracut-version failed'

	# Remove modules not enabled by USE flags
	for module in ${IUSE} ; do
		! use ${module} && rm_module ${module}
	done

	! any_module ${DM_IUSE} && rm_module 90dm
	! any_module ${NETWORK_IUSE} && rm_module 45ifcfg 40network

	# Remove S/390 modules which are not tested at all
	rm_module 95dasd 95dasd_mod 95zfcp 95znet

	# Remove modules which won't work for sure
	rm_module 95fcoe # no tools

	# fips module depends on masked app-crypt/hmaccalc
	rm_module 01fips
}

pkg_postinst() {
	elog 'To generate the initramfs:'
	elog '    # mount /boot (if necessary)'
	elog '    # dracut "" <kernel-version>'
	elog ''
	elog 'For command line documentation see dracut.kernel(7).'
	elog ''
	elog 'Simple example to select root and resume partition:'
	elog '    root=/dev/sda1 resume=/dev/sda2'
	elog ''
	elog 'The default config (in /etc/dracut.conf) is very minimal and is highly'
	elog 'recommended you adjust based on your needs. To include only dracut'
	elog 'modules and kernel drivers for this system, use the "-H" option.'
	elog 'Some modules need to be explicitly added with "-a" option even if'
	elog 'required tools are installed.'
	echo
	ewarn 'dhcp-3 is known to not work with QEMU. You will need dhcp-4 or'
	ewarn 'later for it.'
}
