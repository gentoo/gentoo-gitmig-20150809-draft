# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.0.19.ebuild,v 1.7 2003/09/06 22:21:02 msterret Exp $

MY_P=${P/tex/TeX}-src
S=${WORKDIR}/${MY_P}
DESCRIPTION="GNU TeXmacs is a free GUI scientific editor, inspired by TeX and GNU Emacs."
SRC_URI="ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	 ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"
HOMEPAGE="http://www.texmacs.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=app-text/tetex-1.0.7-r7
	>=dev-util/guile-1.3.4
	=sys-apps/sed-4*
	virtual/x11"

RDEPEND="${DEPEND}
	app-text/ghostscript"

src_compile() {

	econf
	sed -i "s:\(^CXXOPTIMIZE = \).*:\1${CXXFLAGS}:" src/common.makefile

	cd ${S}
	make || die
}


src_install() {

	make DESTDIR=${D} install || die

	cd ${WORKDIR}
	dodir /usr/share/texmf
	cp -r fonts ${D}/usr/share/texmf/

	cd ${S}
	dodoc COMPILE COPYING LICENSE
}
