# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/gift-gnutella-0.0.9.2-r1.ebuild,v 1.1 2005/01/14 20:50:40 squinky86 Exp $

inherit eutils

IUSE=""

DESCRIPTION="The giFT Gnutella plugin"
HOMEPAGE="http://gift.sf.net/"
SRC_URI="mirror://sourceforge/gift/${P}.tar.bz2"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc amd64"

DEPEND="virtual/libc
	dev-util/pkgconfig
	app-arch/bzip2
	>=sys-apps/sed-4"

RDEPEND=">=net-p2p/gift-0.11.6
	>=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc35.patch
	sed -i -e 's:365:999:g' src/gt_gnutella.c
}

src_compile() {
	econf || die "failed to configure"
	emake || die "failed to build"
}

src_install() {
	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/lib/giFT \
		 datadir=${D}/usr/share \
		 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die "Install failed"
}

pkg_postinst() {
	einfo "To run giFT with Gnutella support, run:"
	einfo "\tgiFT -p /usr/lib/giFT/libGnutella.so"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/giftd.conf configuration file:"
	einfo "plugins = Gnutella"
	echo
	ewarn "This version of gift-gnutella does not install proper gwebcaches."
	ewarn "To update your caches, run:"
	ewarn "\tsh /usr/portage/net-p2p/${PN}/files/cacheupdate.sh"
}
