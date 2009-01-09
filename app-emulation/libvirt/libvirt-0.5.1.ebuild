# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.5.1.ebuild,v 1.1 2009/01/09 04:31:31 marineam Exp $

inherit eutils autotools

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
SRC_URI="http://libvirt.org/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi iscsi lvm lxc hal kvm openvz parted qemu sasl selinux uml xen"
# policykit is in package.mask
# devicekit isn't in portage

DEPEND="sys-libs/readline
	sys-libs/ncurses
	>=dev-libs/libxml2-2.5
	>=net-libs/gnutls-1.0.25
	dev-lang/python
	sys-fs/sysfsutils
	net-misc/bridge-utils
	net-analyzer/netcat
	net-dns/dnsmasq
	avahi? ( >=net-dns/avahi-0.6 )
	iscsi? ( sys-block/open-iscsi )
	kvm? ( app-emulation/kvm )
	lvm? ( sys-fs/lvm2 )
	openvz? ( sys-kernel/openvz-sources )
	parted? ( >=sys-apps/parted-1.8 )
	qemu? ( app-emulation/qemu )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( sys-libs/libselinux )
	xen? ( app-emulation/xen-tools app-emulation/xen )
	"
	#policykit? ( >=sys-auth/policykit-0.6 )

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/"${PN}"-0.4.6-qemu-img-name.patch
	epatch "${FILESDIR}"/"${PN}"-0.4.6-parallel-build-fix.patch
	epatch "${FILESDIR}"/"${P}"-libgnu-reposition.patch
	epatch "${FILESDIR}"/"${P}"-add-missing-permission-checks.patch
	eautoreconf
}

pkg_setup() {
	local hasbackend=0
	local backends="lxc kvm openvz qemu uml xen"
	local backend

	for backend in $backends ; do
		use $backend && hasbackend=1
	done

	if [ "$hasbackend" == 0 ]; then
		local msg="You must enable one of these USE flags: $backends"
		eerror "$msg"
		die "$msg"
	fi
}

src_compile() {
	local my_conf=""
	if use qemu || use kvm ; then
		# fix path for kvm-img but use qemu-img if the useflag is set
		my_conf="--with-qemu \
			$(use_with !qemu qemu-img-name kvm-img)"
	else
		my_conf="--without-qemu"
	fi

	econf \
		$(use_with avahi) \
		$(use_with iscsi storage-iscsi) \
		$(use_with lvm storage-lvm) \
		$(use_with lxc) \
		$(use_with hal) \
		$(use_with openvz) \
		$(use_with parted storage-disk) \
		$(use_with sasl) \
		$(use_with selinux) \
		$(use_with uml) \
		$(use_with xen) \
		${my_conf} \
		--without-devkit \
		--without-polkit \
		--with-remote \
		--disable-iptables-lokkit \
		--localstatedir=/var \
		--with-remote-pid-file=/var/run/libvirtd.pid \
		|| die "econf failed"
		#$(use_with policykit) \
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/{${PN}-python*,${P}/python}
	newinitd "${FILESDIR}"/libvirtd.init libvirtd
	newconfd "${FILESDIR}"/libvirtd.confd libvirtd
}

pkg_postinst() {
	elog "To allow normal users to connect to libvirtd you must change the"
	elog " unix sock group and/or perms in /etc/libvirt/libvirtd.conf"
}
