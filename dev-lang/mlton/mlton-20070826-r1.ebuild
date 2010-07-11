# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mlton/mlton-20070826-r1.ebuild,v 1.2 2010/07/11 22:01:52 hwoarang Exp $

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

QA_PRESTRIPPED="
	usr/bin/mlnlffigen
 	usr/bin/mllex
  	usr/bin/mlprof
   	usr/bin/mlyacc
	usr/lib/mlton/mlton-compile"

src_compile() {
	if use !binary; then
		has_version dev-lang/mlton || die "emerge with binary use flag first"

		# Fix location in which to install man pages
		sed -i 's@^MAN_PREFIX_EXTRA :=.*@MAN_PREFIX_EXTRA := /share@' \
			Makefile || die 'sed Makefile failed'

		# Does not support parallel make
		emake -j1 all-no-docs || die
		if use doc; then
			export VARTEXFONTS="${T}/fonts"
			emake docs || die "failed to create documentation"
		fi
	fi
}

src_install() {
	if use binary; then
		# Fix location in which to install man pages
		mv "${WORKDIR}/usr/man" "${WORKDIR}/usr/share" || die "mv man failed"

		mv "${WORKDIR}/usr" "${D}" || die "mv failed"
	else
		emake DESTDIR="${D}" install-no-docs || die
		if use doc; then emake DESTDIR="${D}" TDOC="${D}"/usr/share/doc/${P} install-docs || die; fi
	fi
}
