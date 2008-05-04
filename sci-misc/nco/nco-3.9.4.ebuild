# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/nco/nco-3.9.4.ebuild,v 1.1 2008/05/04 15:41:44 markusle Exp $

DESCRIPTION="Command line utilities for operating on netCDF files"
SRC_URI="http://dust.ess.uci.edu/nco/src/${P}.tar.gz"
HOMEPAGE="http://nco.sourceforge.net/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

IUSE="mpi doc ncap2 udunits"

RDEPEND="sci-libs/netcdf
	mpi? ( virtual/mpi )
	udunits? ( sci-libs/udunits )"

DEPEND="${RDEPEND}
	ncap2? ( !mpi? ( dev-java/antlr ) )
	doc? ( virtual/latex-base )"

pkg_setup() {
	if use mpi && use ncap2; then
		elog
		elog "mpi and ncap2 are still incompatible flags"
		elog "nco configure will automatically disables ncap2"
		elog
	fi
}

src_compile() {
	# let more experimental options enabling via EXTRA_ECONF
	econf \
		$(use_enable ncap2 ncoxx) \
		$(use_enable udunits) \
		$(use_enable mpi) \
		|| die "econf failed"
	emake || die "emake failed"
	cd doc
	emake clean info
	if use doc; then
		emake html pdf || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	cd doc
	dodoc ANNOUNCE ChangeLog MANIFEST NEWS README TAG TODO VERSION *.txt \
		|| die "dodoc failed"
	doinfo *.info* || die "doinfo failed"
	if use doc; then
		dohtml nco.html/* || die "dohtml failed"
		insinto /usr/share/doc/${PF}
		doins nco.pdf || die "pdf install failed"
	fi
}
