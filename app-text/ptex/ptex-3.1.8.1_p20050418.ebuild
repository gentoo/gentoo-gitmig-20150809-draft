# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.8.1_p20050418.ebuild,v 1.3 2006/10/23 12:03:36 usata Exp $

TETEX_PV=3.0

inherit tetex-3 flag-o-matic

DESCRIPTION="The ASCII publishing TeX distribution"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/
	http://www.misojiro.t.u-tokyo.ac.jp/~tutimura/ptetex3/0README
	http://www.fsci.fuk.kindai.ac.jp/aftp/pub/ptex/utils/"

PTEX_TEXMF_PV=2.3
PTEX_SRC="ptex-src-${PV%_*}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"
PTETEX=ptetex3-${PV//*_p}

S=${WORKDIR}/tetex-src-${TETEX_PV}

SRC_PATH_PTEX="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex"
SRC_PATH_TETEX="ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/current/distrib"
TETEX_SRC="tetex-src-${TETEX_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_PV}.tar.gz"
TETEX_TEXMF_SRC=""
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	http://www.misojiro.t.u-tokyo.ac.jp/~tutimura/ptetex3/${PTETEX}.tar.gz
	mirror://gentoo/tetex-${TETEX_PV}-gentoo.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="X"

DEPEND="X? ( >=media-libs/freetype-2
		>=media-fonts/kochi-substitute-20030809-r3
	)"

src_unpack() {
	unpack ${PTETEX}.tar.gz
	tetex-3_src_unpack

	einfo "Unpacking pTeX sources ..."
	cd ${S}/texmf
	echo ">>> Unpacking ${PTEX_TEXMF} to ${S}/texmf ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_TEXMF} || die

	echo ">>> Unpacking jis fonts to ${S}/texmf/fonts ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/jis.tar.gz -C ${T} || die
	mv ${T}/jis/tfm/ptex/* ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/jis/vf/*       ${S}/texmf/fonts/vf/ptex  || die

	echo ">>> Unpacking morisawa fonts to ${S}/texmf/fonts ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/morisawa.tar.gz -C ${T} || die
	mv ${T}/morisawa/tfm/dvips/* ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/morisawa/tfm/ptex/*  ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/morisawa/vf/*        ${S}/texmf/fonts/vf/ptex  || die

	cd ${S}/texk/web2c
	echo ">>> Unpacking ${PTEX_SRC} to ${S}/texk/web2c ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_SRC} || die

	cd ${S}/texk
	echo ">>> Unpacking dvipsk-jpatch to ${S}/texk ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/dvipsk-*.tar.gz || die
	epatch dvipsk-*.patch

	if use X ; then
		cd ${S}
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-*.diff.gz
		epatch ${FILESDIR}/xdvi-xorg-7.0.patch
		cat >>${S}/texk/xdvik/vfontmap.sample<<-EOF

		# TrueType fonts
		min     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		nmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		goth    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		tmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		tgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		ngoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		jis     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		jisg    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		dm      /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		dg      /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		mgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		fmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		fgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		EOF
	fi
}

src_compile() {

	if use X ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
		TETEX_ECONF="${TETEX_ECONF} --with-vflib=vf2ft --enable-freetype"
	fi

	tetex-3_src_compile

	# make ptex.tex visible to ptex
	TEXMF="${S}/texmf" ${S}/texk/kpathsea/mktexlsr || die

	cd ${S}/texk/web2c/${PTEX_SRC%.tar.gz} || die
	chmod +x configure
	./configure EUC || die "configure pTeX failed"

	TEXMF="${S}/texmf" make || die "make pTeX failed"
}

src_install() {
	addwrite /var/cache/fonts
	addwrite /var/lib/texmf
	addwrite /usr/share/texmf

	tetex-3_src_install

	dosym /usr/bin/tex /usr/bin/virtex
	dosym /usr/bin/pdftex /usr/bin/pdfvirtex

	einfo "Installing pTeX ..."
	cd ${S}/texk/web2c/${PTEX_SRC%.tar.gz} || die
	# fix texmf.cnf failure
	sed -i -e "s:\$(web2cdir)/texmf.cnf:${D}${TEXMF_PATH}/texmf.cnf:g" \
		Makefile || die
	TEXMF="${S}/texmf" einstall bindir=${D}/usr/bin texmf=${D}${TEXMF_PATH} || die

	insinto /usr/share/texmf/fonts/map/dvips/tetex
	doins ${FILESDIR}/psfonts-ja.map || die
	insinto /etc/texmf/updmap.d
	doins ${FILESDIR}/20updmap-ja.cfg
	insinto /etc/texmf/fmtutil.d
	doins ${FILESDIR}/20fmtutil-platex.cnf
	insinto /etc/texmf/texmf.d
	sed -i -e '/TEXINPUTS.platex/d' ${D}/etc/texmf/texmf.d/00texmf.cnf
	doins ${FILESDIR}/10texmf-ptex.cnf
	doins ${FILESDIR}/20texmf-cmap.cnf

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
