# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/ha-prosper/ha-prosper-4.21.ebuild,v 1.1 2004/09/08 18:33:05 usata Exp $

inherit latex-package

DESCRIPTION="HA-prosper is a LaTeX class for writing transparencies"
HOMEPAGE="http://stuwww.uvt.nl/~hendri/Downloads/haprosper.html"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/tetex
	>=dev-tex/prosper-1.5
	dev-tex/xkeyval"
S=${WORKDIR}/${PN}
IUSE=""

src_install(){
	cd ${S}/Run
	insinto ${TEXMF}/tex/latex/${PN}/
	doins *.sty *.cfg
	dodir ${TEXMF}/tex/latex/${PN}/Styles
	for i in `find ./Styles/* -maxdepth 1 -type d`
	do
		dodir ${TEXMF}/tex/latex/${PN}/$i
		insinto ${TEXMF}/tex/latex/${PN}/$i/
		doins $i/*
	done
	cd ${S}
	dodoc README
	dodoc Doc/*.tex Doc/*.tex
}
