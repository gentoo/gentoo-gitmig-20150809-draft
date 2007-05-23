# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-ares/gift-ares-0.3.0-r1.ebuild,v 1.9 2007/05/23 20:44:14 gustavoz Exp $

inherit eutils

IUSE=""

DESCRIPTION="Ares Plugin for giFT"
HOMEPAGE="http://gift-ares.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ~ppc sparc x86 ~x86-fbsd"

DEPEND="dev-util/pkgconfig"

RDEPEND=">=net-p2p/gift-0.11.8"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf --datadir=/usr/share/giFT || die "Ares plugin failed to configure"
	emake || die "Ares plugin failed to build"
}

src_install() {
	make DESTDIR=${D} plugindir=/usr/$(get_libdir)/giFT install || die "Ares plugin failed to install"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "It is recommended that you re-run gift-setup as"
	einfo "the user you will run the giFT daemon as:"
	einfo "\tgift-setup"
	echo
	einfo "Alternatively, if this plugin is already"
	einfo "configured,  you can add the following line"
	einfo "to ~/.giFT/giftd.conf"
	einfo "plugins = Ares"
}
