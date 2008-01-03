# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvcgi/dvcgi-0.5.14.ebuild,v 1.1 2008/01/03 23:17:49 dev-zero Exp $

DESCRIPTION="Provides a C++ interface for C++ CGI programs"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvcgi/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="dev-libs/dvutil
	dev-libs/dvnet"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# install API docs manually if USE=doc
	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README NEWS

	if use doc ; then
		# dvutil provides dispatch.h.3
		rm doc/man/man3/dispatch.h.3
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
