# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.2.4.ebuild,v 1.2 2003/12/09 18:04:15 lanius Exp $

# flag-o-matic functions now in portage, no need to inherit it

MY_P=${P/tex/TeX}-src
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU TeXmacs is a free GUI scientific editor, inspired by TeX and GNU Emacs."
SRC_URI="ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	 ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"
HOMEPAGE="http://www.texmacs.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE="spell"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/tetex
	>=dev-util/guile-1.4
	>=sys-apps/sed-4
	virtual/x11
	spell? ( >=app-text/ispell-3.2 )"

DEPEND="${DEPEND}
	virtual/ghostscript"

src_compile() {

	# we're not trusting texmacs optimisations here, so
	# we only want the following two
	strip-flags
	append-flags -fno-default-inline
	append-flags -fno-inline

	econf || die
	# and now replace the detected optimisations with our safer ones
	sed -i "s:\(^CXXOPTIMIZE = \).*:\1${CXXFLAGS}:" src/common.makefile
	# emake b0rked
	make || die

}


src_install() {

	make DESTDIR=${D} install || die
	dodoc COMPILE COPYING LICENSE

	# now install the fonts
	cd ${WORKDIR}
	dodir /usr/share/texmf
	cp -r fonts ${D}/usr/share/texmf/

}
