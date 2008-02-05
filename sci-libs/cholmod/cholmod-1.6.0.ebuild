# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cholmod/cholmod-1.6.0.ebuild,v 1.1 2008/02/05 18:28:00 bicatali Exp $

inherit autotools eutils

MY_PN=CHOLMOD

DESCRIPTION="Sparse Cholesky factorization and update/downdate library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/cholmod"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc metis minimal supernodal"

DEPEND="supernodal? ( virtual/lapack )
	sci-libs/amd
	sci-libs/colamd
	metis? ( sci-libs/camd sci-libs/ccolamd sci-libs/metis )"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch

	# We need to take care of cholmod.h here as well depending on
	# the USE flags, otherwise the installed file will reference
	# headers that we may not have included.
	if use minimal; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NMODIFY 1\n\1 NMATRIXOPS 1\n:}' \
		Include/cholmod_config.h
	fi

	if ! use supernodal; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NSUPERNODAL 1\n:}' \
		Include/cholmod_config.h
	fi

	if ! use metis; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NPARTITION 1\n:}' \
		Include/cholmod_config.h
	fi

	eautoreconf
}

src_compile() {
	local myconf=""

	# Minimal is used to build only the LGPL libraries...
	if use minimal; then
		myconf="--disable-mod-modify
			--disable-mod-matrixops"
	fi

	econf \
		${myconf} \
		$(use_enable supernodal mod-supernodal) \
		$(use_enable metis mod-partition) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	if ! use supernodal || ! use metis || use minimal; then
		ewarn "According to your useflags, some modules were not built on"
		ewarn "purpose.  This can cause the tests included with Cholmod"
		ewarn "to fail.  Rebuild with USE=\"supernodal metis -minimal\""
		ewarn "if you care."
	fi
	cd "${S}"/Demo
	emake test || die "emake test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
	if use doc; then
		dodoc Doc/UserGuide.pdf || die "pdf install failed"
	fi
}
