# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/acml/acml-3.1.0-r1.ebuild,v 1.4 2006/08/17 20:06:58 dberkholz Exp $

inherit eutils

DESCRIPTION="AMD Core Math Library (ACML) for x86 and amd64 CPUs"
HOMEPAGE="http://developer.amd.com/acml.aspx"

MY_PV=${PV//\./\-}
S=${WORKDIR}

SRC_URI="amd64? ( acml-${MY_PV}-gnu-64bit.tgz )
	x86? ( acml-${MY_PV}-gnu-32bit.tgz )"
RESTRICT="fetch nostrip"
IUSE="sse sse2"
LICENSE="ACML"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RDEPEND="virtual/libc
	app-admin/eselect-blas
	app-admin/eselect-cblas
	app-admin/eselect-lapack"
PROVIDE="virtual/blas
	virtual/lapack"

src_unpack() {
	unpack ${A}
	if [ "${ARCH}" == "amd64" ] ; then
		export BITS="64"
	elif [ "${ARCH}" == "x86" ] ; then
		export BITS="32"
		if ! use sse2 ; then
			use sse \
				&& export SUFFIX="_nosse2" \
				|| export SUFFIX="_nosse"
		fi
	fi
	(DISTDIR="${S}" unpack contents-acml-${MY_PV}-gnu-${BITS}bit.tgz)

	mv Doc doc
}

src_compile() {
	return
}

src_install() {
	# Documentation
	cd ${S}/doc
	dodoc acml.*

	# Headers
	mkdir -p ${D}/usr/include/acml/
	cp ${S}/gnu${BITS}${SUFFIX}/include/* ${D}/usr/include/acml/ \
		|| die "Could not copy header file"
	cd ${D}/usr/include
	ln -s acml/acml.h acml.h

	# Libraries
	mkdir -p ${D}/usr/$(get_libdir)/
	cp ${S}/gnu${BITS}${SUFFIX}/lib/* ${D}/usr/$(get_libdir)/ \
		|| die "Could not copy library files"
	unset SUFFIX

	# eselect files
	eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas acml
	eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas acml
	eselect lapack add $(get_libdir) ${FILESDIR}/eselect.lapack acml
}

pkg_postinst() {
	if [[ -z "$(eselect blas show)" ]]; then
		eselect blas set acml
	fi
	if [[ -z "$(eselect cblas show)" ]]; then
		eselect cblas set acml
	fi
	if [[ -z "$(eselect lapack show)" ]]; then
		eselect lapack set acml
	fi

	elog "To use ACML's BLAS features, you have to issue (as root):"
	elog "\n\teselect blas set acml"
	elog "To use ACML's CBLAS features, you have to issue (as root):"
	elog "\n\teselect cblas set acml"
	elog "To use ACML's LAPACK features, you have to issue (as root):"
	elog "\n\teselect lapack set acml"
}
