# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bridge-utils/bridge-utils-1.2.ebuild,v 1.8 2007/05/11 11:13:37 jer Exp $

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

inherit eutils autotools

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

SRC_URI="mirror://sourceforge/bridge/${P}.tar.gz"

IUSE="sysfs"

RDEPEND="virtual/libc
		 virtual/baselayout"
DEPEND="${RDEPEND}
		virtual/os-headers
		>=sys-devel/autoconf-2.59"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	WANT_AUTOMAKE=1.9 eautomake || die "Failed to run autoconf"
	WANT_AUTOCONF=2.5 eautoconf || die "Failed to run autoconf"
}

src_compile() {
	# use santitized headers and not headers from /usr/src
	econf \
		--prefix=/ \
		--libdir=/usr/$(get_libdir) \
		--includedir=/usr/include \
		--with-linux-headers=/usr/include \
		|| die "econf failed"
	emake || die "make failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"
	#einstall prefix=${D} libdir=${D}/usr/lib includedir=${D}/usr/include
	dodoc AUTHORS ChangeLog README THANKS TODO
	dodoc doc/{FAQ,FIREWALL,HOWTO,PROJECTS,RPM-GPG-KEY,SMPNOTES,WISHLIST}
}

pkg_postinst () {
	ewarn "This package no longer provides a seperate init script."
	ewarn "Please utilize the new bridge support in baselayout."
}
