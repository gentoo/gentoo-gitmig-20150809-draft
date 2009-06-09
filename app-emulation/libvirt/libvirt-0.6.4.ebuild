# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.6.4.ebuild,v 1.2 2009/06/09 18:37:33 patrick Exp $

EAPI="2"

inherit eutils autotools confutils

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
SRC_URI="http://libvirt.org/sources/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi iscsi hal kvm lvm +lxc +network nls numa openvz policykit \
	parted qemu sasl selinux uml virtualbox xen"
# devicekit isn't in portage

RDEPEND="sys-libs/readline
	sys-libs/ncurses
	>=dev-libs/libxml2-2.5
	>=net-libs/gnutls-1.0.25
	dev-lang/python
	sys-fs/sysfsutils
	net-analyzer/netcat
	avahi? ( >=net-dns/avahi-0.6 )
	iscsi? ( sys-block/open-iscsi )
	kvm? ( app-emulation/kvm )
	lvm? ( sys-fs/lvm2 )
	network? ( net-misc/bridge-utils net-dns/dnsmasq net-firewall/iptables )
	numa? ( sys-process/numactl )
	openvz? ( sys-kernel/openvz-sources )
	parted? ( >=sys-apps/parted-1.8 )
	policykit? ( >=sys-auth/policykit-0.6 )
	qemu? ( >=app-emulation/qemu-0.10.0 )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( sys-libs/libselinux )
	virtualbox? ( || ( >=app-emulation/virtualbox-ose-2.2.0 >=app-emulation/virtualbox-bin-2.2.0 ) )
	xen? ( app-emulation/xen-tools app-emulation/xen )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# Patch sent upstream for working with kvm-img
	epatch "${FILESDIR}/${P}-kvm-img.patch"
	# upstream patch. fix shared/read-only disk labeling
	epatch "${FILESDIR}/${PN}-0.6.2-shared-readonly-label.patch"
	# upstream patch. don't try to label a disk with no path (empty cdrom)
	epatch "${FILESDIR}/${PN}-0.6.2-fix-nosource-label.patch"
	# Fix logic error when using qemu-img
	epatch "${FILESDIR}/${P}-qemu-img-logic-fix.patch"

	eautoreconf
}

pkg_setup() {
	confutils_require_any lxc kvm openvz qemu uml virtualbox xen
}

src_configure() {
	local my_conf=""
	if use qemu || use kvm ; then
		my_conf="--with-qemu"
	else
		my_conf="--without-qemu"
	fi

	econf \
		$(use_with iscsi storage-iscsi) \
		$(use_with lvm storage-lvm) \
		$(use_with parted storage-disk) \
		$(use_with lxc) \
		$(use_with openvz) \
		$(use_with uml) \
		$(use_with virtualbox vbox) \
		$(use_with xen) \
		$(use_with xen xen-inotify) \
		$(use_with avahi) \
		$(use_with hal) \
		$(use_with sasl) \
		$(use_with network) \
		$(use_with policykit polkit) \
		$(use_with selinux) \
		$(use_enable nls) \
		$(use_with numa numactl) \
		${my_conf} \
		--without-devkit \
		--with-remote \
		--disable-iptables-lokkit \
		--localstatedir=/var \
		--with-remote-pid-file=/var/run/libvirtd.pid
}

src_install() {
	emake DESTDIR="${D}" install || die "emake instal lfailed"
	mv "${D}"/usr/share/doc/{${PN}-python*,${P}/python}

	newinitd "${FILESDIR}/libvirtd.init" libvirtd
	newconfd "${FILESDIR}/libvirtd.confd" libvirtd

	keepdir /var/lib/libvirt/images
}

pkg_postinst() {
	elog "To allow normal users to connect to libvirtd you must change the"
	elog " unix sock group and/or perms in /etc/libvirt/libvirtd.conf"
	elog
	ewarn "If you have a DNS server setup on your machine, you will have"
	ewarn "to configure /etc/dnsmasq.conf to enable the following settings: "
	ewarn " bind-interfaces"
	ewarn " interface or except-interface"
	elog
	ewarn "Otherwise you might have issues with your existing DNS server."
}
