# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bridge-utils/bridge-utils-1.0.6-r3.ebuild,v 1.6 2006/04/25 16:24:55 lu_zero Exp $

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

inherit eutils

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

SRC_URI="mirror://sourceforge/bridge/${P}.tar.gz"

IUSE="sysfs"

RDEPEND="virtual/libc
		 virtual/baselayout"
DEPEND="${RDEPEND}
		sysfs? ( >=sys-fs/sysfsutils-1.0 )
		virtual/os-headers
		=sys-devel/autoconf-2.5*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${P}-dont-error-on-no-ports.patch
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-allow-without-sysfs.patch
	cd ${S} && WANT_AUTOCONF=2.5 autoconf || die "Failed to run autoconf"
}

src_compile() {
	# use santitized headers and not headers from /usr/src
	econf \
		--prefix=/ \
		--libdir=/usr/lib \
		--includedir=/usr/include \
		--with-linux-headers=/usr/include \
		`use_with sysfs` \
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
