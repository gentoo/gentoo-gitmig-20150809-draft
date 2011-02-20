# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-0.20.0-r1.ebuild,v 1.3 2011/02/20 17:35:07 phajdan.jr Exp $

EAPI=2

inherit eutils

DESCRIPTION="A library handling connections to a MPD server"
HOMEPAGE="http://gmpc.wikia.com/wiki/Libmpd"
SRC_URI="http://download.sarine.nl/Programs/gmpc/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-overflow.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
