# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift/gift-0.11.4.ebuild,v 1.4 2003/12/26 14:22:03 weeve Exp $

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network client"
HOMEPAGE="http://gift.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha ~amd64"

DEPEND="virtual/glibc
	!net-p2p/gift
	>=sys-apps/sed-4
	>=sys-libs/zlib-1.1.4"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall \
		giftconfdir=${D}/etc/giFT \
		plugindir=${D}/usr/lib/giFT \
		giftdatadir=${D}/usr/share/giFT \
		giftperldir=${D}/usr/bin \
		libgiftincdir=${D}/usr/include/libgift || die "Install failed"
}

pkg_postinst() {
	einfo "First, you need to run giFT-setup with your normal"
	einfo "user account to create the giFT configuration files."
	echo
	einfo "This package no longer contains any protocol plugins,"
	einfo "please try gift-fasttrack, gift-openft, gift-gnutella"
	einfo "for protocol support."
	echo
	einfo "If you encounter issues with this package, please contact"
	einfo "us via bugs.gentoo.org rather than attempting to contact"
	einfo "the upstream developers, as they are hesitant to provide"
	einfo "appropriate and polite support"
}
