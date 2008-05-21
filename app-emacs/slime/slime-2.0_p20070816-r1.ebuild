# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-2.0_p20070816-r1.ebuild,v 1.4 2008/05/21 17:40:24 ulm Exp $

inherit common-lisp elisp eutils

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 xref.lisp"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="virtual/commonlisp"
DEPEND="${RDEPEND}
	doc? ( sys-apps/texinfo
		virtual/latex-base
		|| ( dev-texlive/texlive-texinfo app-text/tetex app-text/ptex ) )"

CLPACKAGE=swank
SWANK_VERSION="2007-08-16"
SITEFILE=71${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/slime-set-swank-wire-protocol-version.patch
	epatch "${FILESDIR}"/${P}-save-restriction-if-possible.patch
	sed -i "s:@SWANK-WIRE-PROTOCOL-VERSION@:${SWANK_VERSION}:" swank.lisp
}

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
	emake -j1 -C doc slime.info || die "emake slime.info failed"
	if use doc; then
		VARTEXFONTS="${T}"/fonts \
			emake -j1 -C doc slime.{ps,pdf} || die "emake doc failed"
	fi
}

src_install() {
	elisp-install ${PN} *.el{,c} "${FILESDIR}"/swank-loader.lisp \
		|| die "Cannot install SLIME core"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	insinto "${CLSOURCEROOT}"/swank
	doins *.lisp "${FILESDIR}"/swank.asd
	dodir "${CLSYSTEMROOT}"
	dosym "${CLSOURCEROOT}"/swank/swank.asd "${CLSYSTEMROOT}"
	dosym "${SITELISP}"/${PN}/swank-version.el "${CLSOURCEROOT}"/swank

	dodoc README* ChangeLog HACKING NEWS PROBLEMS || die "dodoc failed"
	doinfo doc/slime.info
	if use doc; then
		dodoc doc/slime.{ps,pdf} || die "dodoc failed"
	fi
}
