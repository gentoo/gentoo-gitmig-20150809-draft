# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtompoly/libtompoly-0.04.ebuild,v 1.4 2005/03/17 00:43:18 vapier Exp $

DESCRIPTION="portable ISO C library for polynomial basis arithmetic"
HOMEPAGE="http://poly.libtomcrypt.org/"
SRC_URI="http://poly.libtomcrypt.org/files/ltp-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
