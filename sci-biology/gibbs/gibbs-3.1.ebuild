# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/gibbs/gibbs-3.1.ebuild,v 1.4 2009/12/24 18:34:19 pacho Exp $

EAPI="2"

inherit autotools

DESCRIPTION="The Gibbs Motif Sampler identifies motifs, conserved regions, in DNA or protein sequences"
HOMEPAGE="http://bayesweb.wadsworth.org/gibbs/gibbs.html"
SRC_URI="mirror://gentoo/gibbs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="mpi"
KEYWORDS="amd64 ~x86"

DEPEND="mpi? ( virtual/mpi
	sys-cluster/mpe2 )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/CFLAGS="$OPTFLAGS/CFLAGS="$CFLAGS $OPTFLAGS/' \
		-e 's/-Werror//' configure.in || die
	eautoreconf
}

src_configure() {
	if use mpi; then export CC=mpicc; fi
	econf $(use_enable mpi) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	exeinto /usr/share/${PN}
	doexe *.pl
	dodoc README ChangeLog
}

pkg_postinst() {
	einfo "Supplementary Perl scripts for Gibbs have been installed into /usr/share/${PN}."
	einfo "These scripts require installation of sci-biology/bioperl."
}
