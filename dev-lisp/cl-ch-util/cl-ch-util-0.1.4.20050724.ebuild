# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ch-util/cl-ch-util-0.1.4.20050724.ebuild,v 1.1 2005/07/25 06:22:31 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Cyrus Harmon's Common Lisp utility library."
HOMEPAGE="http://www.cyrusharmon.org/cl/blog/"
SRC_URI="http://cyrusharmon.org/cl/static/releases/ch-util-${PV/.2005/-2005}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/ch-util

CLPACKAGE='ch-util ch-util-test'

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-fasl-output-gentoo.patch || die
	rm ${S}/Makefile
}

src_install() {
	dodir $CLSYSTEMROOT
	insinto $CLSOURCEROOT/ch-util
	doins *.{cl,asd}
	insinto $CLSOURCEROOT/ch-util/src/
	doins src/*.cl
	insinto $CLSOURCEROOT/ch-util/test/
	doins test/*.cl
	dosym ${CLSOURCEROOT}/ch-util/ch-util.asd ${CLSYSTEMROOT}/ch-util.asd
	dosym ${CLSOURCEROOT}/ch-util/ch-util-test.asd ${CLSYSTEMROOT}/ch-util-test.asd
	dodoc COPYRIGHT README
}
