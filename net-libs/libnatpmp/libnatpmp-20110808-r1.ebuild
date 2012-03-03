# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnatpmp/libnatpmp-20110808-r1.ebuild,v 1.3 2012/03/03 15:41:53 maekke Exp $

EAPI=4
inherit eutils toolchain-funcs multilib

DESCRIPTION="An alternative protocol to UPnP IGD specification."
HOMEPAGE="http://miniupnp.free.fr/libnatpmp.html"
SRC_URI="http://miniupnp.free.fr/files/download.php?file=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="static-libs"

src_prepare() {
	epatch "${FILESDIR}"/respect-FLAGS.patch
	epatch "${FILESDIR}"/respect-libdir.patch
	use !static-libs && epatch "${FILESDIR}"/remove-static-lib.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${D}" GENTOO_LIBDIR="$(get_libdir)" install

	dodoc Changelog.txt README
	doman natpmpc.1
}
