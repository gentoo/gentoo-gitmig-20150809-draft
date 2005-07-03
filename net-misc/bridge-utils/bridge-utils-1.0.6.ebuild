# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bridge-utils/bridge-utils-1.0.6.ebuild,v 1.4 2005/07/03 01:24:30 robbat2 Exp $

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

SRC_URI="mirror://sourceforge/bridge/${P}.tar.gz"

IUSE=""
RDEPEND="virtual/libc
	>=sys-fs/sysfsutils-1.0
	>=sys-apps/baselayout-1.11.6"
DEPEND="${RDEPEND} virtual/os-headers"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

src_compile() {
	# use santitized headers and not headers from /usr/src
	econf \
		--prefix=/ \
		--libdir=/usr/lib \
		--includedir=/usr/include \
		--with-linux-headers=/usr/include \
		|| die "econf failed"
	emake || die "make failed"
}

src_install () {
	emake install DESTDIR="${D}"
	#einstall prefix=${D} libdir=${D}/usr/lib includedir=${D}/usr/include
	dodoc AUTHORS ChangeLog README THANKS TODO
	dodoc doc/{FAQ,FIREWALL,HOWTO,PROJECTS,RPM-GPG-KEY,SMPNOTES,WISHLIST}
}

pkg_postinst () {
	ewarn "This package no longer provides a seperate init script."
	ewarn "Please utilize the new bridge support in baselayout."
}
