# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiiimcf/libiiimcf-11.4.1467.ebuild,v 1.2 2003/09/14 01:45:36 usata Exp $

inherit iiimf

DESCRIPTION="A library to implement generic C interface for IIIM Client"

DEPEND="dev-libs/eimil
	dev-libs/libiiimp"

S="${WORKDIR}/${IMSDK}/lib/iiimcf"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S} ; autoconf
}
