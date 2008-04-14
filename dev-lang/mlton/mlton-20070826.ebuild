# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mlton/mlton-20070826.ebuild,v 1.1 2008/04/14 21:06:20 hkbst Exp $

inherit eutils

DESCRIPTION="Standard ML optimizing compiler and libraries"
BASE_URI="http://mlton.org/pages/Download/attachments/"
SRC_URI="!binary? ( ${BASE_URI}/${P}-1.src.tgz )
		  binary? ( amd64? ( ${BASE_URI}/${P}-1.amd64-linux.tgz )
					x86?   ( ${BASE_URI}/${P}-1.x86-linux.tgz ) )"

HOMEPAGE="http://www.mlton.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE="binary doc"

#block mlton-bin until it has been removed
DEPEND="dev-libs/gmp
		!dev-lang/mlton-bin
		doc? ( virtual/latex-base )"

src_compile() {
	if use !binary; then
		has_version dev-lang/mlton || die "emerge with binary use flag first"

		# Does not support parallel make
		emake -j1 all-no-docs || die
		if use doc; then emake docs || die; fi
	fi
}

src_install() {
	if use binary; then
		mv "${WORKDIR}/usr" "${D}"
	else
		emake DESTDIR="${D}" install-no-docs || die
		if use doc; then emake DESTDIR="${D}" TDOC="${D}"/usr/share/doc/${P} install-docs || die; fi
	fi
}
