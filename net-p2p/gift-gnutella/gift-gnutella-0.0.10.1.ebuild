# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/gift-gnutella-0.0.10.1.ebuild,v 1.4 2006/04/29 22:48:54 halcy0n Exp $

inherit eutils

IUSE=""

DESCRIPTION="The giFT Gnutella plugin"
HOMEPAGE="http://gift.sf.net/"
SRC_URI="mirror://sourceforge/gift/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND="virtual/libc
	dev-util/pkgconfig
	app-arch/bzip2
	sys-libs/zlib"

RDEPEND=">=net-p2p/gift-0.11.6"

src_compile() {
	econf || die "failed to configure"
	emake || die "failed to build"
}

src_install() {
	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/$(get_libdir)/giFT \
		 datadir=${D}/usr/share \
		 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die "Install failed"
}

pkg_postinst() {
	einfo "It is recommended that you re-run gift-setup as"
	einfo "the user you will run the giFT daemon as:"
	einfo "\tgift-setup"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/giftd.conf configuration file:"
	einfo "plugins = Gnutella"
	echo
	einfo "To update your caches, run:"
	einfo "\tsh /usr/portage/net-p2p/${PN}/files/cacheupdate.sh"
}
