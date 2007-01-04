# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.85.9.ebuild,v 1.15 2007/01/04 13:35:54 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

IUSE=""

DESCRIPTION="Direct Connect Text Client, almost famous file share program"
HOMEPAGE="http://brainz.servebeer.com/dctc/"
SRC_URI="http://brainz.servebeer.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"

RDEPEND="=dev-libs/glib-2*
	>=sys-libs/db-3
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/dctc-0.85.6-passive.patch
	epatch "${FILESDIR}"/dctc-0.85.9-gcc41.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc Documentation/* Documentation/DCextensions/*
	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
