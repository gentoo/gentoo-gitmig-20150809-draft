# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hlatex/hlatex-0.991.ebuild,v 1.1 2004/09/02 01:34:51 usata Exp $

inherit latex-package

DESCRIPTION="HLaTeX is a LaTeX package to use Hangul with LaTeX."
HOMEPAGE="http://ftp.ktug.or.kr/mirrors/HLaTeX/hlatex.html"
#SRC_URI="ftp://ftp.dante.de/tex-archive/languages/korean/HLaTeX.tar.gz ftp://ftp.dante.de/tex-archive/fonts/korean/HLaTeX.tar.gz"
SRC_URI="http://user.chollian.net/~jh1228/data/gentoo/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/tetex"

add_line() {

	FILE=$1
	STRING=$2

	if [ -z "`grep "^${STRING}$" ${FILE}`" ]
	then
		echo "${STRING}" >>  ${FILE}
	fi

}

del_line() {

	FILE=$1
	STRING=$2

	cp ${FILE} ${FILE}.temp
	CMD=`echo "/^${STRING}$/d"`
	sed -e "${CMD}" ${FILE}.temp > ${FILE}
	rm ${FILE}.temp

}

src_install() {

	dodir ${TEXMF}/dvipdfm/uhc
	cp -a uhc-dvipdfm.map ${D}${TEXMF}/dvipdfm/uhc

	dodir ${TEXMF}/pdftex/uhc
	cp -a uhc-pdftex.map ${D}${TEXMF}/pdftex/uhc

	cd ${S}/HLaTeX

	dodir ${TEXMF}/tex/latex/hlatex
	cp -a hfont.tex hangul.sty hfont.sty josa.tab hfont.cfg \
		uhc/latex/* moonttf/*.fd moonttf/moonttf.sty \
		${D}${TEXMF}/tex/latex/hlatex

	dodir ${TEXMF}/omega/latex/hlatex
	cp -a uhc/lambda/*.tex uhc/lambda/*.fd ${D}${TEXMF}/omega/latex/hlatex

	dodir ${TEXMF}/omega/otp/hlatex
	cp -a uhc/lambda/ksx1001.otp ${D}${TEXMF}/omega/otp/hlatex

	dodir ${TEXMF}/omega/ocp/hlatex
	cp -a uhc/lambda/ksx1001.ocp ${D}${TEXMF}/omega/ocp/hlatex

	dodir ${TEXMF}/bibtex/bst/misc
	cp -a contrib/halpha.bst ${D}${TEXMF}/bibtex/bst/misc

	dodir ${TEXMF}/makeindex
	cp -a contrib/hind.ist contrib/hglo.ist ${D}${TEXMF}/makeindex

	dodir ${TEXMF}/dvips/config
	cp -a uhc/config/uhc-down.map ${D}${TEXMF}/dvips/config

	dodoc changelog.ks hlatex-en.html hlatex-ko.html hlatex.html \
		hlguide.bib hlguide.tex news.099 readme.eng \
	docinto doc
	dodoc doc/*

	cd ${S}/Fonts

	for i in *
	do
		gunzip -c $i | tar xvf -
		rm $i
	done

	dodir ${TEXMF}/fonts
	cp -a * ${D}${TEXMF}/fonts

}

pkg_postinst() {

	add_line "${TEXMF}/dvips/config/config.ps" "p +uhc-down.map"
	add_line "${TEXMF}/pdftex/config/pdftex.cfg" "map +uhc-pdftex.map"
	add_line "${TEXMF}/dvipdfm/config/config" "f uhc-dvipdfm.map"

	texhash

}

pkg_postrm() {

	del_line "${TEXMF}/dvips/config/config.ps" "p +uhc-down.map"
	del_line "${TEXMF}/pdftex/config/pdftex.cfg" "map +uhc-pdftex.map"
	del_line "${TEXMF}/dvipdfm/config/config" "f uhc-dvipdfm.map"

	texhash

}

