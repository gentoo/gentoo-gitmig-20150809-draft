# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.5-r2.ebuild,v 1.2 2006/10/23 12:03:36 usata Exp $

PTEX_TEXMF_PV=2.3
TETEX_PV=2.0.2

inherit tetex-2

DESCRIPTION="The ASCII publishing TeX distribution"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/"

PTEX_SRC="ptex-src-${PV}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"
PTETEX="ptetex2-20050522"
PTETEX_CMAP="ptetex-cmap-20051117"

SRC_URI="${SRC_URI}
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex2/${PTETEX}.tar.gz
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex-cmap/${PTETEX_CMAP}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="X"

DEPEND="X? ( >=media-libs/freetype-2
	>=media-fonts/kochi-substitute-20030809-r3 )
	!app-text/xdvik"

src_unpack() {
	unpack ${PTETEX}.tar.gz
	unpack ${PTETEX_CMAP}.tar.gz
	tetex-2_src_unpack

	einfo "Unpacking pTeX sources..."
	cd ${S}/texmf
	echo ">>> Unpacking ${PTEX_TEXMF} to ${S}/texmf ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_TEXMF} || die

	echo ">>> Unpacking jis fonts to ${S}/texmf/fonts ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/jis.tar.gz -C ${T} || die
	mv ${T}/jis/tfm/ptex/* ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/jis/vf*        ${S}/texmf/fonts/vf/ptex  || die

	echo ">>> Unpacking morisawa fonts to ${S}/texmf/fonts ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/morisawa.tar.gz -C ${T} || die
	mv ${T}/morisawa/tfm/dvips/* ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/morisawa/tfm/ptex/*  ${S}/texmf/fonts/tfm/ptex || die
	mv ${T}/morisawa/vf/*        ${S}/texmf/fonts/vf/ptex  || die

	cd ${S}/texmf/fonts
	echo ">>> Unpacking CMap fonts to ${S}/texmf/fonts ..."
	unzip ${WORKDIR}/${PTETEX_CMAP}/adobe-cmaps-200406.zip || die

	cd ${S}/texk/web2c
	echo ">>> Unpacking ${PTEX_SRC} to ${S}/texk/web2c ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_SRC} || die

	cd ${S}/texk
	echo ">>> Unpacking dvipsk-jpatch to ${S}/texk ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/dvipsk-jpatch-p1.6a1.tar.gz || die
	epatch dvipsk-5.92b-p1.6a1.patch

	if use X ; then
		cd ${S}
		epatch ${WORKDIR}/${PTETEX}/archive/tetex-src-2.0.2-xdvik-y1.patch.gz
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-22.40y1-j1.21.patch.gz
		epatch ${WORKDIR}/${PTETEX}/archive/tetex-src-2.0.2-xdvik-y1-j1.19.patch.gz
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-22.40y1-waitpid.patch
		epatch ${FILESDIR}/xdvi-xorg-7.0.patch
		sed -i -e "/\/usr\/local/s:^:%:g" \
			-e "/kochi-.*-subst/s:%::g" \
			-e "s:/usr/local:/usr:g" \
			-e "s:/usr/X11R6/lib/X11/fonts/truetype:/usr/share/fonts/kochi-substitute:g" \
			${S}/texk/xdvik/vfontmap.freetype || die
		cd texk/oxdvik
		ln -s ../xdvik/*.{c,h} ./
		cp -f ../xdvik/Makefile.in.oxdvi Makefile.in
		cp -f ../xdvik/c-auto.in ./
	fi

	# bug 75801
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-CESA-2004-007-xpdf2-newer.diff
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf-goo-sizet.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf2-underflow.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl2-CAN-2004-1125.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl3-CAN-2005-0064.patch
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xdvizilla.patch

	#bug 115775
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p2" epatch ${FILESDIR}/xpdf-2.02pl1-CAN-2005-3191-3.patch

	#bug 122365
	EPATCH_OPTS="-d ${WORKDIR}" epatch ${FILESDIR}/${P}-flex-unput.patch

	# bug 118264
	EPATCH_OPTS="-d ${WORKDIR} -p0" epatch ${FILESDIR}/${P}-dvi-draw-conflicting-types.patch

}

src_compile() {
	if use X ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
		TETEX_ECONF="--with-vflib=vf2ft"
	fi

	tetex_src_compile

	cat >>${S}/texk/web2c/fmtutil.cnf<<-EOF

	# Japanese pLaTeX:
	ptex		ptex	-		ptex.ini
	platex		ptex	language.dat	platex.ini
	platex209	ptex	language.dat	plplain.ini
	EOF

	cat >>${S}/texk/kpathsea/texmf.cnf<<-EOF

	CMAPINPUTS = .;/opt/Acrobat5/Resource/Font//;/opt/Acrobat7/Resource/Font//;/usr/share/xpdf//;/usr/share/ghostscript/Resource//;/usr/share/texmf/fonts/CMap//
	EOF

	cd ${S}/texk/web2c/${PN}-src-${PV} || die
	./configure EUC || die "configure pTeX failed"

	make programs || die "make pTeX failed"
}

src_install() {
	tetex-2_src_install

	einfo "Installing pTeX..."
	cd ${S}/texk/web2c/${PN}-src-${PV} || die
	einstall bindir=${D}/usr/bin texmf=${D}/usr/share/texmf || die

	insinto /usr/share/texmf/dvips/config
	doins ${FILESDIR}/psfonts-ja.map || die
	cat >>${D}/usr/share/texmf/web2c/updmap.cfg<<-EOF

	# Japanese fonts
	MixedMap psfonts-ja.map
	EOF

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
