# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt/libvirt-0.2.3.ebuild,v 1.1 2007/06/10 05:56:29 dberkholz Exp $

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="http://www.libvirt.org/"
SRC_URI="http://libvirt.org/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qemu xen"

DEPEND="sys-libs/readline
	sys-libs/ncurses
	dev-libs/libxml2
	qemu? ( app-emulation/qemu )
	xen? ( app-emulation/xen-tools )
	dev-lang/python
	sys-fs/sysfsutils"

pkg_setup() {
	if ! use qemu && ! use xen; then
		local msg="You must enable one of these USE flags: qemu xen"
		eerror "$msg"
		die "$msg"
	fi
}

src_compile() {
	econf \
		$(use_with qemu) \
		$(use_with xen) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	mv ${D}/usr/share/doc/{${PN}-python*,${P}/python}
}
