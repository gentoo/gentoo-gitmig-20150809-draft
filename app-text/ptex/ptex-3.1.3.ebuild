# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.3.ebuild,v 1.13 2004/07/29 02:37:15 tgall Exp $

PTEX_TEXMF_PV=2.1
TETEX_PV=2.0.2

inherit tetex eutils

DESCRIPTION="The ASCII publishing TeX distribution"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/"

PTEX_SRC="ptex-src-${PV}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"

SRC_PATH_PTEX="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex"
SRC_URI="${SRC_URI}
	${SRC_PATH_PTEX}/tetex/${PTEX_SRC}
	${SRC_PATH_PTEX}/tetex/${PTEX_TEXMF}
	${SRC_PATH_PTEX}/dvips/dvipsk-jpatch-p1.6.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="x86 alpha amd64 ppc sparc ppc64"
IUSE=""

PDEPEND="app-text/xdvik"

src_unpack() {
	tetex_src_unpack

	einfo "Unpacking pTeX sources..."
	cd ${S}/texmf
	unpack ${PTEX_TEXMF}

	cd ${S}/texk/web2c
	unpack ${PTEX_SRC}

	cd ${S}/texk
	unpack dvipsk-jpatch-p1.6.tar.gz
	epatch dvipsk-5.92b-p1.6.patch
}

src_compile() {
	tetex_src_compile

	cat >>${S}/texk/web2c/fmtutil.cnf<<-EOF

	# Japanese pLaTeX:
	ptex		ptex	-		ptex.ini
	platex		ptex	language.dat	platex.ini
	platex209	ptex	language.dat	plplain.ini
	EOF

	cat >>${S}/texk/web2c/texmf.cnf<<-EOF

	CMAPINPUTS = .;/opt/Acrobat5/Resource/Font//;/usr/share/xpdf//
	EOF

	cd ${S}/texk/web2c/${PN}-src-${PV} || die
	./configure EUC || die "configure pTeX failed"

	make programs || die "make pTeX failed"
}

src_install() {
	tetex_src_install

	einfo "Installing pTeX..."
	cd ${S}/texk/web2c/${PN}-src-${PV} || die
	einstall bindir=${D}/usr/bin texmf=${D}/usr/share/texmf || die

	insinto /usr/share/texmf/dvips/config
	newins ${FILESDIR}/psfonts-novflib-ja.map psfonts-ja.map
	cat >>${D}/usr/share/texmf/web2c/updmap.cfg<<-EOF

	# Japanese fonts
	MixedMap psfonts-ja.map
	EOF

	docinto dvipsk
	cd ${S}/texk/dvipsk
	dodoc ../ChangeLog.jpatch ../README.jpatch
}
