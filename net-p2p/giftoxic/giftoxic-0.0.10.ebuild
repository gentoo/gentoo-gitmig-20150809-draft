# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftoxic/giftoxic-0.0.10.ebuild,v 1.4 2004/10/16 12:03:16 slarti Exp $

IUSE=""

MY_P="giFToxic-${PV}"
DESCRIPTION="A GTK+2 giFT frontend"
HOMEPAGE="http://giftoxic.sourceforge.net/"
SRC_URI="mirror://sourceforge/giftoxic/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=x11-libs/gtk+-2.0.3
	net-p2p/gift"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --prefix=/usr || die "econf failed"
	make CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}
