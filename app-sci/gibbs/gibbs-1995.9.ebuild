# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gibbs/gibbs-1995.9.ebuild,v 1.4 2004/11/01 01:50:38 ribosome Exp $

DESCRIPTION="A Gibbs sampling algorithm for local alignment of subtle sequence signals in multiple protein sequences."

HOMEPAGE="http://www.people.fas.harvard.edu/~junliu/index1.html"

SRC_NAME="gibbs9_95"    # 9_95 refers to the september 1995 version
SRC_URI="http://www.fas.harvard.edu/~junliu/Software/${SRC_NAME}.tar"

LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${SRC_NAME}/code

src_compile() {
	LIBS="-lm" make -e || die
}

src_install() {
	cd ${WORKDIR}/${SRC_NAME}
	dobin gibbs purge scan
	dobin ${FILESDIR}/gibbs-demo

	dodoc README

	insinto /usr/share/${PN}
	doins demo.out
	insinto /usr/share/${PN}/examples
	doins examples/*
}

pkg_postinst() {
	einfo 'Testcase: To ensure the gibbs sampler works correctly,'
	einfo 'run "gibbs-demo > mydemo.out" and compare "mydemo.out"'
	einfo 'with "/usr/share/gibbs/demo.out" using diff. The files'
	einfo 'should differ only by their timing statistics and the'
	einfo 'paths of the example files.'
}
