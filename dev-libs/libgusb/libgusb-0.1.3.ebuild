# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgusb/libgusb-0.1.3.ebuild,v 1.10 2012/05/16 14:59:23 jer Exp $

EAPI=4

DESCRIPTION="GObject wrapper for libusb"
HOMEPAGE="https://gitorious.org/gusb/"
SRC_URI="http://people.freedesktop.org/~hughsient/releases/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ~mips ~ppc ~ppc64 x86"
IUSE="static-libs"

# udev is effectively a required dependency: configuring with --disable-gudev
# causes build failures
RDEPEND=">=dev-libs/glib-2.28
	dev-libs/libusb:1
	|| ( sys-fs/udev[gudev] sys-fs/udev[extras] )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-libs/libxslt
	virtual/pkgconfig"
# eautoreconf requires dev-util/gtk-doc-am

# Tests try to access usb devices in /dev
RESTRICT="test"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
