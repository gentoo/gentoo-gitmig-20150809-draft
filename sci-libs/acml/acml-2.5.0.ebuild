# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/acml/acml-2.5.0.ebuild,v 1.1 2005/04/03 15:23:48 kugelfang Exp $

inherit eutils

DESCRIPTION="AMD Core Math Library (ACML) for x86 and amd64 CPUs"
HOMEPAGE="http://www.developwithamd.com/appPartnerProg/acml/forms/index.cfm?action=home"

MY_PV=${PV//\./\-}
S=${WORKDIR}

SRC_URI="amd64? ( acml-64bit-${MY_PV}.tgz )
	x86? ( acml-32bit-${MY_PV}.tgz )"
RESTRICT="fetch nostrip"
IUSE=""
LICENSE="ACML"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RDEPEND="virtual/libc
	sci-libs/blas-config
	sci-libs/lapack-config"
PROVIDE="virtual/blas
	virtual/lapack"

src_unpack() {
	unpack ${A}
	if [ "${ARCH}" == "amd64" ]; then
		export SUFFIX="64"
	else
		export SUFFIX="32"
	fi
	(DISTDIR="${S}" unpack contents${SUFFIX}.tgz)

	# Remove non-gnu libraries...
	# TODO: probably a useflag for non-gnu libraries to be used ?
	rm -Rf ${S}/pgi* install*.sh README*
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
	cp ${S}/gnu${SUFFIX}/include/* ${D}/usr/include/acml/

	# Libraries
	mkdir -p ${D}/usr/$(get_libdir)/
	cp ${S}/gnu${SUFFIX}/lib/* ${D}/usr/$(get_libdir)/
	unset SUFFIX

	# Configfiles
	mkdir -p ${D}/usr/$(get_libdir)/{blas,lapack}
	for x in ${FILESDIR}/*.{blas,lapack}; do
		y="$(basename $x)"
		cp $x ${D}/usr/$(get_libdir)/${y/*\.}/${y/\.*}
	done
}

pkg_postinst() {
	einfo "To use ACML's BLAS features, you have to issue (as root):"
	einfo "\n\t/usr/bin/blas-config ACML"
	einfo "To use ACML's LAPACK features, you have to issue (as root):"
	einfo "\n\t/usr/bin/lapack-config ACML"
}
