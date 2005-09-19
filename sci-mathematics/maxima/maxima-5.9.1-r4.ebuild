# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/maxima/maxima-5.9.1-r4.ebuild,v 1.1 2005/09/19 04:24:15 ribosome Exp $

inherit eutils elisp-common

DESCRIPTION="Free computer algebra environment, based on Macsyma"
HOMEPAGE="http://maxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 AECA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cmucl clisp sbcl tetex emacs auctex"

DEPEND="tetex? ( virtual/tetex )
	emacs? ( virtual/emacs )
	auctex? ( app-emacs/auctex )
	>=sys-apps/texinfo-4.3
	!clisp? ( !sbcl? ( !cmucl? ( >=dev-lisp/gcl-2.6.7 ) ) )
	cmucl? ( >=dev-lisp/cmucl-19a )
	clisp? ( >=dev-lisp/clisp-2.33.2-r1 )
	sbcl?  ( >=dev-lisp/sbcl-0.8.14 )"
RDEPEND=">=dev-lang/tk-8.3.3
	 >=media-gfx/gnuplot-4.0-r1"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/maxima-${PV}-unicode-fix.patch
	cd "${S}"/interfaces/emacs/emaxima
	epatch "${FILESDIR}"/maxima-emacs.patch
}

src_compile() {
	local myconf
	if use cmucl || use clisp || use sbcl; then
		if use cmucl; then
			myconf="${myconf} --enable-cmucl"
		fi
		if use clisp; then
			myconf="${myconf} --enable-clisp"
		fi
		if use sbcl; then
			myconf="${myconf} --enable-sbcl"
		fi
	else
		if ! built_with_use dev-lisp/gcl ansi; then
			eerror "GCL must be installed with ANSI."
			eerror "Try USE=\"ansi\" emerge gcl"
			die "This package needs gcl with USE=ansi"
		fi
		myconf="${myconf} --enable-gcl"
	fi
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if use emacs
	then
		elisp-site-file-install "${FILESDIR}"/50maxima-gentoo.el
	fi
	if use tetex
	then
		insinto /usr/share/texmf/tex/latex/emaxima
		doins "${S}"/interfaces/emacs/emaxima/emaxima.sty
	fi

	# Install documentation.
	insinto /usr/share/${PN}/${PV}/doc
	doins AUTHORS ChangeLog COPYING NEWS README*
	dodir /usr/share/doc
	dosym /usr/share/${PN}/${PV}/doc /usr/share/doc/${PF}
}

pkg_postinst() {
	if use emacs
	then
		einfo "Running elisp-site-regen...."
		elisp-site-regen
	fi
	if use tetex
	then
		einfo "Running mktexlsr to rebuild ls-R database...."
		mktexlsr
	fi
}

pkg_postrm() {
	if use emacs
	then
		einfo "Running elisp-site-regen...."
		elisp-site-regen
	fi
}
