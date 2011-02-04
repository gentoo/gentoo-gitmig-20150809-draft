# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.8.7.ebuild,v 1.6 2011/02/04 17:39:52 angelos Exp $

#BACKPORTS=1
#AUTOTOOLIZE=yes

EAPI="2"

PYTHON_DEPEND="python? 2:2.4"
#RESTRICT_PYTHON_ABIS="3.*"
#SUPPORT_PYTHON_ABIS="1"

inherit eutils python ${AUTOTOOLIZE+autotools}

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
SRC_URI="http://libvirt.org/sources/${P}.tar.gz
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.bz2
		http://dev.gentoo.org/~cardoe/${PN}/${P}-backports-${BACKPORTS}.tar.bz2}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="avahi caps debug iscsi +json +libvirtd lvm +lxc macvtap +network nfs \
	nls numa openvz parted pcap phyp policykit python qemu sasl selinux udev \
	uml virtualbox virt-network xen"
# IUSE=one : bug #293416 & bug #299011

RDEPEND="sys-libs/readline
	sys-libs/ncurses
	>=net-misc/curl-7.18.0
	>=dev-libs/libxml2-2.7.6
	>=dev-libs/libnl-1.1
	>=net-libs/gnutls-1.0.25
	sys-fs/sysfsutils
	sys-apps/util-linux
	>=net-analyzer/netcat6-1.0-r2
	avahi? ( >=net-dns/avahi-0.6[dbus] )
	caps? ( sys-libs/libcap-ng )
	iscsi? ( sys-block/open-iscsi )
	json? ( dev-libs/yajl )
	libvirtd? ( net-misc/bridge-utils )
	lvm? ( >=sys-fs/lvm2-2.02.48-r2 )
	macvtap? ( >=dev-libs/libnl-1.1 )
	nfs? ( net-fs/nfs-utils )
	numa? ( sys-process/numactl )
	openvz? ( sys-kernel/openvz-sources )
	parted? ( >=sys-block/parted-1.8[device-mapper] )
	pcap? ( >=net-libs/libpcap-1.0.0 )
	phyp? ( net-libs/libssh2 )
	policykit? ( >=sys-auth/polkit-0.9 )
	qemu? ( || ( app-emulation/qemu-kvm >=app-emulation/qemu-0.10.0 app-emulation/qemu-kvm-spice ) )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( >=sys-libs/libselinux-2.0.85 )
	virtualbox? ( || ( app-emulation/virtualbox >=app-emulation/virtualbox-bin-2.2.0 ) )
	xen? ( app-emulation/xen-tools app-emulation/xen )
	udev? ( >=sys-fs/udev-145 >=x11-libs/libpciaccess-0.10.9 )
	virt-network? ( net-dns/dnsmasq
		>=net-firewall/iptables-1.4.10
		net-firewall/ebtables
		sys-apps/iproute2 )"
# one? ( dev-libs/xmlrpc-c )
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	# This is required to be able to run the tests when using the sandbox
	if [[ ${LD_PRELOAD} == libsandbox.so ]]; then
		sed -i -e '/LOGNAME/iENV:LD_PRELOAD=libsandbox.so' \
			"${S}"/tests/commanddata/*.log || die
		sed -i -e '/DISPLAY/aENV:LD_PRELOAD=libsandbox.so' \
			"${S}"/tests/commanddata/test6.log || die
		sed -i -e '/LANG/aENV:LD_PRELOAD=libsandbox.so' \
			"${S}"/tests/commanddata/test8.log || die
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
	myconf="${myconf} $(use_with openvz)"
	myconf="${myconf} $(use_with lxc)"
	if use virtualbox && has_version app-emulation/virtualbox-ose; then
		myconf="${myconf} --with-vbox=/usr/lib/virtualbox-ose/"
	else
		myconf="${myconf} $(use_with virtualbox vbox)"
	fi
	myconf="${myconf} $(use_with uml)"
	myconf="${myconf} $(use_with qemu)"
	# doesn't belong with hypervisors but links to libvirtd for some reason
	#myconf="${myconf} $(use_with one)"

	## hypervisor protocols
	myconf="${myconf} $(use_with phyp)"
	myconf="${myconf} --with-esx"

	## additional host drivers
	myconf="${myconf} $(use_with network)"
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

	# network biits
	myconf="${myconf} $(use_with macvtap)"
	myconf="${myconf} $(use_with pcap libpcap)"

	## other
	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_with python)"
	myconf="${myconf} $(use_with json yajl)"

	## stuff we don't yet support
	myconf="${myconf} --without-netcf --without-audit"

	# we use udev over hal
	myconf="${myconf} --without-hal"

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
		--localstatedir=/var \
		--with-remote-pid-file=/var/run/libvirtd.pid
}

src_test() {
	# Explicitly allow parallel build of tests
	emake check || die "tests failed"
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

	newinitd "${FILESDIR}/libvirtd.init-r1" libvirtd || die
	newconfd "${FILESDIR}/libvirtd.confd-r1" libvirtd || die

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
}

pkg_postinst() {
	use python && python_mod_optimize $(python_get_sitedir)/libvirt.py

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
	use python && python_mod_cleanup $(python_get_sitedir)/libvirt.py
}
