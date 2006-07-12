# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-20050601.ebuild,v 1.1 2006/07/12 13:21:35 nattfodd Exp $

inherit autotools elisp-common

DESCRIPTION="Agda is a proof assistant in Haskell."
HOMEPAGE="http://www.cs.chalmers.se/~catarina/agda"
SRC_URI="http://www.coverproject.org/Agda/Agda-1.1-cvs${PV}.tar.gz"
S="${WORKDIR}/Agda-1.1-cvs${PV}"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
# make html is currently broken
#IUSE="doc emacs"
IUSE="emacs"

DEPEND="virtual/ghc
		emacs? ( virtual/emacs )"
	#doc? ( dev-haskell/haddock) "
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PN}-make_install.patch
	eaclocal -I macros || die "aclocal failed"
	eautoconf || die "autoconf failed"
}

src_compile() {
	cd "${S}"
	econf || die "./configure failed"
	emake || die "make failed"
	#if use doc ; then
	#	emake html
	#fi
}

src_install() {
	if use emacs; then
		cd "${S}/elisp"
		elisp-install ${PN} *.el
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
	cd "${S}/src"
	make prefix="${D}/usr" install || die "make install failed"
	dosym /usr/lib/EmacsAgda/bin/emacsagda /usr/bin/emacsagda
	dosym /usr/bin/emacsagda /usr/bin/agda
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}
