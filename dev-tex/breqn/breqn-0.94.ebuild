# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/breqn/breqn-0.94.ebuild,v 1.2 2004/11/25 10:24:47 dragonheart Exp $

inherit latex-package

MY_P=${P//[-.]/}

DESCRIPTION="LaTeX package for line breaking of equations."
HOMEPAGE="http://www.ams.org/"
SRC_URI="ftp://ftp.ams.org/pub/tex/${MY_P}.tgz"
LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc"

S=${WORKDIR}/${MY_P}

src_install() {
	latex-package_src_install

	insinto ${TEXMF}/tex/latex/${PN}
	doins *.sym

	dodoc *.txt
}
