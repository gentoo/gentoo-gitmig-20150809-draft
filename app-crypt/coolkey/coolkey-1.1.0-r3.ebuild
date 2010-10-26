# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/coolkey/coolkey-1.1.0-r3.ebuild,v 1.1 2010/10/26 03:24:55 nerdboy Exp $

EAPI=3

inherit eutils

DESCRIPTION="Linux Driver support for the CoolKey and CAC products"
HOMEPAGE="http://directory.fedora.redhat.com/wiki/CoolKey"
SRC_URI="http://directory.fedora.redhat.com/download/coolkey/${P}.tar.gz
	mirror://gentoo/${PN}-patches-20101024.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND=">=sys-apps/pcsc-lite-1.6.4
	sys-libs/zlib"

DEPEND="${RDEPEND}
	>=app-crypt/ccid-1.4.0
	dev-util/pkgconfig"

src_prepare() {
	epatch "${WORKDIR}/${PN}-patches/01_${P}-cache-dir-move.patch"
	epatch "${WORKDIR}/${PN}-patches/02_${P}-gcc43.patch"
	epatch "${WORKDIR}/${PN}-patches/03_${P}-latest.patch"
	epatch "${WORKDIR}/${PN}-patches/04_${P}-simple-bugs.patch"
	epatch "${WORKDIR}/${PN}-patches/05_${P}-thread-fix.patch"
	epatch "${WORKDIR}/${PN}-patches/06_${P}-cac.patch"
	epatch "${WORKDIR}/${PN}-patches/07_${P}-cac-1.patch"
	epatch "${WORKDIR}/${PN}-patches/08_${P}-pcsc-lite-fix.patch"
}

src_configure() {
	econf $(use_enable debug) || die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	diropts -m 1777
	keepdir /var/cache/coolkey
}
