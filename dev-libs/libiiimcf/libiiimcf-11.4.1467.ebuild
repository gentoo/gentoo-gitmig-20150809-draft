# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiiimcf/libiiimcf-11.4.1467.ebuild,v 1.6 2004/07/14 14:42:05 agriffis Exp $

inherit iiimf eutils

DESCRIPTION="A library to implement generic C interface for IIIM Client"

KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/eimil
	dev-libs/libiiimp"

S="${WORKDIR}/${IMSDK}/lib/iiimcf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	autoconf
}
