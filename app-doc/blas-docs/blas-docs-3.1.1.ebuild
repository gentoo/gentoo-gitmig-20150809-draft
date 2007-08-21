# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/blas-docs/blas-docs-3.1.1.ebuild,v 1.2 2007/08/21 17:42:59 fmccor Exp $

DESCRIPTION="Documentation reference and man pages for blas implementations"
HOMEPAGE="http://www.netlib.org/blas"
SRC_URI="mirror://gentoo/lapack-man-${PV}.tgz
	http://www.netlib.org/blas/blasqr.ps
	http://www.netlib.org/blas/blast-forum/blas-report.ps"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 sparc ~x86"
IUSE=""

S=${WORKDIR}/lapack-${PV}/manpages

src_install() {
	# rename because doman do not yet understand manl files
	rename .l .n blas/man/manl/*
	doman blas/man/manl/*.n || die "doman failed"
	dodoc README "${DISTDIR}"/blas{-report,qr}.ps || die "dodoc failed"
}
