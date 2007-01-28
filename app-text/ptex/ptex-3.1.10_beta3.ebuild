# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.10_beta3.ebuild,v 1.2 2007/01/28 06:00:36 genone Exp $

TETEX_PV=3.0

inherit tetex-3 flag-o-matic

DESCRIPTION="The ASCII publishing TeX distribution"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/
	http://www.misojiro.t.u-tokyo.ac.jp/~tutimura/ptetex3/0README
	http://www.fsci.fuk.kindai.ac.jp/aftp/pub/ptex/utils/"

PTEX_TEXMF_PV=2.4
PTEX_SRC="ptex-src-${PV/_b/-B}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"
PTETEX="ptetex3-20061108"
PTETEX_CMAP="ptetex-cmap-20051117"

S=${WORKDIR}/tetex-src-${TETEX_PV}

SRC_PATH_PTEX="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex"
SRC_PATH_TETEX="ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/current/distrib"
TETEX_SRC="tetex-src-${TETEX_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_PV}.tar.gz"
TETEX_TEXMF_SRC=""
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex3/${PTETEX}.tar.gz
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex-cmap/${PTETEX_CMAP}.tar.gz
	mirror://gentoo/tetex-${TETEX_PV}-gentoo.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~arm ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sh ~sparc ~x86"
IUSE="X motif lesstif Xaw3d neXt"

DEPEND=">=app-text/tetex-3
	!<app-text/ptetex-3.1.9
	X? ( >=media-libs/freetype-2.1.10
		media-fonts/kochi-substitute
	)"
# it doesn't provide tetex anymore
PROVIDE=""

src_unpack() {
	unpack ${PTETEX}.tar.gz
	unpack ${PTETEX_CMAP}.tar.gz
	tetex-3_src_unpack

	einfo "Unpacking pTeX sources ..."
	cd ${S}/texmf
	echo ">>> Unpacking ${PTEX_TEXMF} to ${S}/texmf ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_TEXMF} || die

	echo ">>> Unpacking jis and morisawa fonts ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/jis.tar.gz -C ${WORKDIR} || die
	tar xzf ${WORKDIR}/${PTETEX}/archive/morisawa.tar.gz -C ${WORKDIR} || die

	cd ${S}/texk/web2c
	echo ">>> Unpacking ${PTEX_SRC} to ${S}/texk/web2c ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_SRC} || die

	cd ${S}/texk
	echo ">>> Unpacking dvipsk-jpatch to ${S}/texk ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/dvipsk-5.95b-p1.7a.tar.gz || die
	epatch dvipsk-5.95b-p1.7a.diff

	if use X ; then
		cd ${S}
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-tetex-3.0-22.84.10.diff.gz
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-tetex-3.0-20061107.diff.gz
		epatch ${FILESDIR}/xdvi-xorg-7.0.patch
	fi
}

src_compile() {

	if use X ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
		TETEX_ECONF="${TETEX_ECONF} --with-vflib=vf2ft --enable-freetype"
		TETEX_ECONF="${TETEX_ECONF} --program-prefix=p"
	fi

	tetex-3_src_compile

	# make ptex.tex visible to ptex
	TEXMF="${S}/texmf" ${S}/texk/kpathsea/mktexlsr || die

	cd ${S}/texk/web2c/ptex-src-* || die
	chmod +x configure
	./configure EUC || die "configure pTeX failed"

	TEXMF="${S}/texmf" make || die "make pTeX failed"
}

src_install() {
	addwrite /var/cache/fonts
	addwrite /var/lib/texmf
	addwrite /usr/share/texmf

	#tetex-3_src_install

	einfo "Installing pTeX texmf ..."
	cd ${S}/texmf
	insinto /usr/share/texmf
	doins -r ptex
	doins -r jbibtex

	einfo "Installing pdvips and pxdvik ..."
	cd ${S}/texk/xdvik
	dobin pxdvi*.bin      || die
	newbin xdvi-sh pxdvi  || die
	dosym /usr/bin/pxdvi /usr/bin/opxdvi || die
	insinto /var/lib/texmf/xdvi
	newins ${FILESDIR}/ptex-xdvi-vfontmap-kochi-substitute vfontmap || die
	cd ${S}/texk/dvipsk
	newbin dvips pdvips   || die
	dosym /usr/bin/pdvips /usr/bin/opdvips || die
	insinto /var/lib/fonts/map/dvips/ptex
	doins psfonts_jp.map

	rm -f ${D}/usr/bin/afm2tfm || die

	#dosym /usr/bin/tex /usr/bin/virtex
	#dosym /usr/bin/pdftex /usr/bin/pdfvirtex

	einfo "Installing pTeX ..."
	cd ${S}/texk/web2c/ptex-src-* || die
	# fix texmf.cnf failure
	sed -i -e "s:\$(web2cdir)/texmf.cnf:${D}${TEXMF_PATH}/texmf.cnf:g" \
		Makefile || die
	TEXMF="${S}/texmf" einstall bindir=${D}/usr/bin texmf=${D}${TEXMF_PATH} || die

	# conflict with ones from tetex
	rm -f ${D}/usr/bin/tftopl || die
	rm -f ${D}/usr/bin/pltotf || die

	# fonts
	cd ${S}/texmf/fonts
	einfo "Installing source fonts ..."
	insinto /usr/share/texmf/fonts/source
	doins -r ${S}/texmf/fonts/source/ascgrp || die "installing source/ascgrp failed"
	doins -r ${S}/texmf/fonts/source/ptex   || die "installing source/ptex failed"

	einfo "Installing CMap fonts ..."
	cd ${D}/usr/share/texmf/fonts
	unzip ${WORKDIR}/${PTETEX_CMAP}/adobe-cmaps-200406.zip || die
	cd -

	einfo "Installing vf and tfm fonts ..."
	insinto /usr/share/texmf/fonts/tfm
	doins -r ${S}/texmf/fonts/tfm/ascgrp || die "installing tfm/ascgrp failed"
	doins -r ${S}/texmf/fonts/tfm/ptex   || die "installing tfm/ptex failed"
	doins -r ${WORKDIR}/jis/tfm/*        || die "installing jis/tfm failed"
	doins -r ${WORKDIR}/morisawa/tfm/*   || die "installing morisawa/tfm failed"
	insinto /usr/share/texmf/fonts/vf
	doins -r ${S}/texmf/fonts/vf/ptex || die "installing ptex/vf failed"
	doins -r ${WORKDIR}/jis/vf/*      || die "installing jis/vf failed"
	doins -r ${WORKDIR}/morisawa/vf/* || die "installing morisawa/vf failed"

	# populating /etc/texmf
	insinto /usr/share/texmf/fonts/map/dvips/tetex
	doins ${FILESDIR}/psfonts-ja.map || die
	insinto /etc/texmf/updmap.d
	doins ${FILESDIR}/20updmap-ja.cfg
	insinto /etc/texmf/fmtutil.d
	doins ${FILESDIR}/20fmtutil-platex.cnf
	insinto /etc/texmf/texmf.d
	doins ${FILESDIR}/10texmf-ptex.cnf
	doins ${FILESDIR}/20texmf-cmap.cnf
	for cfg in ptex/plain/config/ptex.ini \
			   ptex/platex/config/platex.ini \
			   ptex/platex/config/hyphen.cfg; do
		insinto /etc/texmf/${cfg%/*}
		doins ${D}/usr/share/texmf/${cfg}
		rm -f ${D}/usr/share/texmf/${cfg}
		dosym /etc/texmf/${cfg%/*} /usr/share/texmf/${cfg}
	done

	docinto dvipsk
	cd ${S}/texk/dvipsk
	dodoc ../ChangeLog.jpatch ../README.jpatch

	if use X ; then
		cd ${S}/texk/xdvik
		docinto xdvik
		dodoc ANNOUNCE BUGS CHANGES.xdvik-jp FAQ README.*
		docinto xdvik/READMEs
		dodoc READMEs/*
	fi
}

pkg_postinst() {
	# earlier declaration of TEXINPUTS hides our ptex configuration
	sed -i -e '/TEXINPUTS.platex/d' ${ROOT}/etc/texmf/texmf.d/00texmf.cnf
	tetex-3_pkg_postinst

	elog
	elog "Japanese dvips and xdvi have been renamed to pdvips and pxdvi."
	elog "You also need to emerge app-text/dvipdfmx to convert dvi into PDF."
	elog
}
