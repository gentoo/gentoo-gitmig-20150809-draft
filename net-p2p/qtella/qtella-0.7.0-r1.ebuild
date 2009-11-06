# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.7.0-r1.ebuild,v 1.11 2009/11/06 22:18:14 ssuominen Exp $

EAPI=2
inherit eutils multilib qt3

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz
	http://squinky.gotdns.com/${P}-libyahoo.patch.gz"
HOMEPAGE="http://qtella.sourceforge.net/"
DESCRIPTION="Excellent Qt3 Gnutella Client"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="x11-libs/qt:3"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-nokde.patch
	epatch "${FILESDIR}"/${P}-errno.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
	epatch "${WORKDIR}"/${P}-libyahoo.patch
}

src_configure() {
	econf \
		--with-kde=no
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog THANKS
}
