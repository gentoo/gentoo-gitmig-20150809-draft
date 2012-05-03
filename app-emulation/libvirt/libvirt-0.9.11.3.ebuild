# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.9.11.3.ebuild,v 1.2 2012/05/03 18:49:06 jdhore Exp $

EAPI=4

#BACKPORTS=1
#AUTOTOOLIZE=yes

MY_P="${P/_rc/-rc}"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://libvirt.org/libvirt.git"
	GIT_ECLASS="git-2"
	AUTOTOOLIZE=yes
fi

PYTHON_DEPEND="python? 2:2.5"
#RESTRICT_PYTHON_ABIS="3.*"
#SUPPORT_PYTHON_ABIS="1"

inherit eutils python ${AUTOTOOLIZE+autotools} ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://libvirt.org/sources/${MY_P}.tar.gz
		ftp://libvirt.org/libvirt/${MY_P}.tar.gz
		${BACKPORTS:+
			http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-bp-${BACKPORTS}.tar.bz2}"
	KEYWORDS="~amd64 ~x86"
fi
S="${WORKDIR}/${P%_rc*}"

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="avahi caps debug iscsi +libvirtd lvm +lxc macvtap nfs \
	nls numa openvz parted pcap phyp policykit python qemu sasl selinux +udev \
	uml virtualbox virt-network xen elibc_glibc"
# IUSE=one : bug #293416 & bug #299011
REQUIRED_USE="libvirtd? ( || ( lxc openvz qemu uml virtualbox xen ) )
	lxc? ( libvirtd ) openvz? ( libvirtd ) qemu? ( libvirtd ) uml? ( libvirtd )
	virtualbox? ( libvirtd ) xen? ( libvirtd )"

# gettext.sh command is used by the libvirt command wrappers, and it's
# non-optional, so put it into RDEPEND.
RDEPEND="sys-libs/readline
	sys-libs/ncurses
	>=net-misc/curl-7.18.0
	>=dev-libs/libxml2-2.7.6
	>=dev-libs/libnl-1.1:1.1
	>=net-libs/gnutls-1.0.25
	sys-apps/dmidecode
	>=sys-apps/util-linux-2.17
	sys-devel/gettext
	>=net-analyzer/netcat6-1.0-r2
	app-misc/scrub
	avahi? ( >=net-dns/avahi-0.6[dbus] )
	caps? ( sys-libs/libcap-ng )
	iscsi? ( sys-block/open-iscsi )
	libvirtd? ( net-misc/bridge-utils )
	lvm? ( >=sys-fs/lvm2-2.02.48-r2 )
	nfs? ( net-fs/nfs-utils )
	numa? ( >sys-process/numactl-2.0.2 )
	openvz? ( sys-kernel/openvz-sources )
	parted? (
		>=sys-block/parted-1.8[device-mapper]
		sys-fs/lvm2
	)
	pcap? ( >=net-libs/libpcap-1.0.0 )
	phyp? ( net-libs/libssh2 )
	policykit? ( >=sys-auth/polkit-0.9 )
	qemu? ( || ( app-emulation/qemu-kvm >=app-emulation/qemu-0.10.0 )
		dev-libs/yajl )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( >=sys-libs/libselinux-2.0.85 )
	virtualbox? ( || ( app-emulation/virtualbox >=app-emulation/virtualbox-bin-2.2.0 ) )
	xen? ( app-emulation/xen-tools app-emulation/xen )
	udev? ( >=sys-fs/udev-145 >=x11-libs/libpciaccess-0.10.9 )
	virt-network? ( net-dns/dnsmasq
		>=net-firewall/iptables-1.4.10
		net-firewall/ebtables
		sys-apps/iproute2[-minimal] )
	elibc_glibc? ( || ( >=net-libs/libtirpc-0.2.2-r1 <sys-libs/glibc-2.14 ) )"
# one? ( dev-libs/xmlrpc-c )
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/xhtml1"

pkg_setup() {
	use python && python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	if [[ ${PV} = *9999* ]]; then
		# git checkouts require bootstrapping to create the configure script.
		# Additionally the submodules must be cloned to the right locations
		# bug #377279
		./bootstrap || die "bootstrap failed"
		(
			git submodule status | sed 's/^[ +-]//;s/ .*//'
			git hash-object bootstrap.conf
		) >.git-module-status
	fi

	[[ -n ${AUTOTOOLIZE} ]] && eautoreconf
}

src_configure() {
	local myconf=""

	myconf="${myconf} $(use_enable debug)"

	## enable/disable daemon, otherwise client only utils
	myconf="${myconf} $(use_with libvirtd)"

	## enable/disable the daemon using avahi to find VMs
	myconf="${myconf} $(use_with avahi)"

	## hypervisors on the local host
	myconf="${myconf} $(use_with xen) $(use_with xen xen-inotify)"
	 # leave it automagic as it depends on the version of xen used.
	use xen || myconf+=" --without-libxl"

	myconf="${myconf} $(use_with openvz)"
	myconf="${myconf} $(use_with lxc)"
	if use virtualbox && has_version app-emulation/virtualbox-ose; then
		myconf="${myconf} --with-vbox=/usr/lib/virtualbox-ose/"
	else
		myconf="${myconf} $(use_with virtualbox vbox)"
	fi
	myconf="${myconf} $(use_with uml)"
	myconf="${myconf} $(use_with qemu)"
	myconf="${myconf} $(use_with qemu yajl)" # Use QMP over HMP
	# doesn't belong with hypervisors but links to libvirtd for some reason
	#myconf="${myconf} $(use_with one)"

	## hypervisor protocols
	myconf="${myconf} $(use_with phyp)"
	myconf="${myconf} --with-esx"

	## additional host drivers
	myconf="${myconf} $(use_with virt-network network)"
	myconf="${myconf} --with-storage-fs"
	myconf="${myconf} $(use_with lvm storage-lvm)"
	myconf="${myconf} $(use_with iscsi storage-iscsi)"
	myconf="${myconf} $(use_with parted storage-disk)"
	myconf="${myconf} $(use_with lvm storage-mpath)"
	myconf="${myconf} $(use_with numa numactl)"
	myconf="${myconf} $(use_with selinux)"

	# udev for device support details
	myconf="${myconf} $(use_with udev)"

	# linux capability support so we don't need privileged accounts
	myconf="${myconf} $(use_with caps capng)"

	## auth stuff
	myconf="${myconf} $(use_with policykit polkit)"
	myconf="${myconf} $(use_with sasl)"

	# network bits
	myconf="${myconf} $(use_with macvtap)"
	myconf="${myconf} $(use_with pcap libpcap)"

	## other
	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_with python)"

	## stuff we don't yet support
	myconf="${myconf} --without-netcf --without-audit"

	# we use udev over hal
	myconf="${myconf} --without-hal"

	# locking support
	myconf="${myconf} --without-sanlock"

	# this is a nasty trick to work around the problem in bug
	# #275073. The reason why we don't solve this properly is that
	# it'll require us to rebuild autotools (and we don't really want
	# to do that right now). The proper solution has been sent
	# upstream and should hopefully land in 0.7.7, in the mean time,
	# mime the same functionality with this.
	case ${CHOST} in
		*cygwin* | *mingw* )
			;;
		*)
			ac_cv_prog_WINDRES=no
			;;
	esac

	econf \
		${myconf} \
		--disable-static \
		--docdir=/usr/share/doc/${PF} \
		--with-remote \
		--localstatedir=/var

	if [[ ${PV} = *9999* ]]; then
		# Restore gnulib's config.sub and config.guess
		# bug #377279
		(cd .gnulib && git reset --hard > /dev/null)
	fi
}

src_test() {
	# Explicitly allow parallel build of tests
	HOME="${T}" emake check || die "tests failed"
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		HTML_DIR=/usr/share/doc/${PF}/html \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/examples \
		|| die "emake install failed"

	find "${D}" -name '*.la' -delete || die

	use libvirtd || return 0
	# From here, only libvirtd-related instructions, be warned!

	newinitd "${FILESDIR}/libvirtd.init-r8" libvirtd || die
	newconfd "${FILESDIR}/libvirtd.confd-r3" libvirtd || die

	keepdir /var/lib/libvirt/images
}

pkg_preinst() {
	# we only ever want to generate this once
	if [[ -e "${ROOT}"/etc/libvirt/qemu/networks/default.xml ]]; then
		rm -rf "${D}"/etc/libvirt/qemu/networks/default.xml
	fi

	# We really don't want to use or support old PolicyKit cause it
	# screws with the new polkit integration
	if has_version sys-auth/policykit; then
		rm -rf "${D}"/usr/share/PolicyKit/policy/org.libvirt.unix.policy
	fi

	# Only sysctl files ending in .conf work
	mv "${D}"/etc/sysctl.d/libvirtd "${D}"/etc/sysctl.d/libvirtd.conf
}

pkg_postinst() {
	use python && python_mod_optimize libvirt.py

	elog
	if use policykit && has_version sys-auth/policykit; then
		elog "You must have run the following at least once:"
		elog
		elog "$ polkit-auth --grant org.libvirt.unix.manage --user \"USERNAME\""
		elog
		elog "to grant USERNAME access to libvirt when using USE=policykit"
	else
		elog "To allow normal users to connect to libvirtd you must change the"
		elog " unix sock group and/or perms in /etc/libvirt/libvirtd.conf"
	fi

	use libvirtd || return 0
	# From here, only libvirtd-related instructions, be warned!

	elog
	elog "For the basic networking support (bridged and routed networks)"
	elog "you don't need any extra software. For more complex network modes"
	elog "including but not limited to NATed network, you can enable the"
	elog "'virt-network' USE flag."
	elog
	if has_version net-dns/dnsmasq; then
		ewarn "If you have a DNS server setup on your machine, you will have"
		ewarn "to configure /etc/dnsmasq.conf to enable the following settings: "
		ewarn " bind-interfaces"
		ewarn " interface or except-interface"
		ewarn
		ewarn "Otherwise you might have issues with your existing DNS server."
	fi
}

pkg_postrm() {
	use python && python_mod_cleanup libvirt.py
}
