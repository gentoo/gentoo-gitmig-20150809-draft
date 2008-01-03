# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.16.ebuild,v 1.1 2008/01/03 23:00:28 dev-zero Exp $

DESCRIPTION="Provides an interface wrapping sockets into streams"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="dev-libs/dvutil"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS
	use doc && dohtml doc/html/*
}
