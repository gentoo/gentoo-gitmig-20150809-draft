# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/sextractor/sextractor-2.8.6.ebuild,v 1.1 2009/07/28 17:39:02 bicatali Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Extract catalogs of sources from astronomical FITS images."
HOMEPAGE="http://astromatic.iap.fr/software/sextractor"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads"

RDEPEND="virtual/cblas
	>=sci-libs/lapack-atlas-3.8.0
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-configure.patch
	# gentoo uses cblas instead of ptcblas (linked to threaded with eselect)
	sed -i \
		-e 's/ptcblas/cblas/g' \
		acx_atlas.m4 || die "sed acx_atlas.m4 failed"
	eautoreconf
}

src_configure() {
	econf \
		--with-atlas="/usr/$(get_libdir)/lapack/atlas" \
		$(use_enable threads)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README THANKS
	CONFDIR=/usr/share/sextractor
	insinto ${CONFDIR}
	doins config/* || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/* || die
	fi
}

pkg_postinst() {
	elog "SExtractor examples configuration files are located"
	elog "in ${CONFDIR} and are not loaded anymore by default."
}
