# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.4.2.ebuild,v 1.1 2008/05/15 10:13:12 dberkholz Exp $

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
SRC_URI="http://libvirt.org/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi iscsi lvm openvz parted qemu sasl selinux xen" #policykit is in package.mask

DEPEND="sys-libs/readline
	sys-libs/ncurses
	>=dev-libs/libxml2-2.5
	>=net-libs/gnutls-1.0.25
	dev-lang/python
	sys-fs/sysfsutils
	avahi? ( >=net-dns/avahi-0.6 )
	iscsi? ( sys-block/open-iscsi )
	lvm? ( sys-fs/lvm2 )
	openvz? ( sys-kernel/openvz-sources )
	parted? ( >=sys-apps/parted-1.8 )
	qemu? ( app-emulation/qemu )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( sys-libs/libselinux )
	xen? ( app-emulation/xen-tools app-emulation/xen )
	"
	#policykit? ( >=sys-auth/policykit-0.6 )

pkg_setup() {
	if ! use qemu && ! use xen && ! use openvz; then
		local msg="You must enable one of these USE flags: qemu xen openvz"
		eerror "$msg"
		die "$msg"
	fi
}

src_compile() {
	econf \
		$(use_with avahi) \
		$(use_with iscsi storage-iscsi) \
		$(use_with lvm storage-lvm) \
		$(use_with openvz) \
		$(use_with parted storage-disk) \
		$(use_with qemu) \
		$(use_with sasl) \
		$(use_with selinux) \
		$(use_with xen) \
		--disable-iptables-lokkit \
		|| die "econf failed"
		#$(use_with policykit) \
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/{${PN}-python*,${P}/python}
}
