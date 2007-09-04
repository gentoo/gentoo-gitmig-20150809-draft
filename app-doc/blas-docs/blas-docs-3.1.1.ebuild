# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/blas-docs/blas-docs-3.1.1.ebuild,v 1.7 2007/09/04 11:52:12 angelos Exp $

DESCRIPTION="Documentation reference and man pages for blas implementations"
HOMEPAGE="http://www.netlib.org/blas"
SRC_URI="mirror://gentoo/lapack-man-${PV}.tgz
	http://www.netlib.org/blas/blasqr.ps
	http://www.netlib.org/blas/blast-forum/blas-report.ps"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/lapack-${PV}/manpages

src_install() {
	# rename because doman do not yet understand manl files
	# Not all systems have the rename command, like say FreeBSD
	local f= t=
	for f in blas/man/manl/*.l; do
		t="${f%%.l}.n"
		mv "${f}" "${t}"
	done
	doman blas/man/manl/*.n || die "doman failed"
	dodoc README "${DISTDIR}"/blas{-report,qr}.ps || die "dodoc failed"
}
