# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiiimcf/libiiimcf-11.4.1467.ebuild,v 1.4 2004/04/21 16:42:33 vapier Exp $

inherit iiimf eutils

DESCRIPTION="A library to implement generic C interface for IIIM Client"

KEYWORDS="~x86"

DEPEND="dev-libs/eimil
	dev-libs/libiiimp"

S="${WORKDIR}/${IMSDK}/lib/iiimcf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	autoconf
}
