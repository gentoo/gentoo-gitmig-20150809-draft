# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/coolkey/coolkey-1.1.0-r1.ebuild,v 1.2 2008/05/08 07:42:38 alonbl Exp $

inherit eutils

DESCRIPTION="Linux Driver support for the CoolKey and CAC products"
HOMEPAGE="http://directory.fedora.redhat.com/wiki/CoolKey"
SRC_URI="http://directory.fedora.redhat.com/download/coolkey/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="debug"
RDEPEND="sys-apps/pcsc-lite
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-cache-move.patch"
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
}

src_compile() {
	econf $(use_enable debug) || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	diropts -m 1777
	keepdir /var/cache/coolkey
}
