# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.4-r1.ebuild,v 1.7 2006/05/01 11:07:23 ehmsen Exp $

inherit flag-o-matic

MY_P=${P/tex/TeX}-R3-src
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU TeXmacs is a free GUI scientific editor, inspired by TeX and GNU Emacs."
SRC_URI="ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	 ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"
HOMEPAGE="http://www.texmacs.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE="spell"
# TeXmacs 1.0.X-r? -> stable release, TeXmacs 1.0.X.Y -> development release
KEYWORDS="x86 ppc alpha sparc"

RDEPEND="virtual/tetex
	>=dev-util/guile-1.4
	>=sys-apps/sed-4
	media-libs/freetype
	|| ( ( x11-libs/libX11
		   x11-libs/libICE )
	    virtual/x11
	)
	media-libs/imlib2
	spell? ( >=app-text/ispell-3.2 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto
		 virtual/x11 )
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
	emake -j1 || die

}


src_install() {

	make DESTDIR=${D} install || die
	dodoc COMPILE

	insinto /usr/share/applications
	doins ${FILESDIR}/TeXmacs.desktop

	# now install the fonts
	cd ${WORKDIR}
	dodir /usr/share/texmf
	cp -r fonts ${D}/usr/share/texmf/

}
