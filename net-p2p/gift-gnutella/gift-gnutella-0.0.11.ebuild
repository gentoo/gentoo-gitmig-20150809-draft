# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/gift-gnutella-0.0.11.ebuild,v 1.8 2007/05/16 06:25:28 opfer Exp $

inherit eutils

IUSE="xml"

DESCRIPTION="The giFT Gnutella plugin"
HOMEPAGE="http://gift.sf.net/"
SRC_URI="mirror://sourceforge/gift/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86 ~x86-fbsd"

DEPEND="virtual/libc
	dev-util/pkgconfig
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/libxml2"

RDEPEND=">=net-p2p/gift-0.11.6"

src_compile() {
	econf $(use_with xml libxml) || die "failed to configure"
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
