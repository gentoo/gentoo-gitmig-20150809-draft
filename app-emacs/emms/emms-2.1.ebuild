# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms/emms-2.1.ebuild,v 1.1 2006/09/04 04:46:24 mkennedy Exp $

inherit elisp toolchain-funcs eutils

DESCRIPTION="EMMS is the Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/ http://www.emacswiki.org/cgi-bin/wiki/EMMS"
SRC_URI="http://www.gnu.org/software/emms/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND="virtual/emacs"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	media-libs/taglib"

# EMMS can use almost anything for playing media files therefore the dependency
# posibilities are so broad that we refrain from setting anything explicitly in
# DEPEND/RDEPEND.

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.0-taglib-Makefile-gentoo.patch
}

src_compile() {
	make CC="$(tc-getCC)" \
		EMACS=emacs \
		DESTDIR=/usr/share/emacs/site-lisp/emms \
		all emms-print-metadata \
		|| die
}

src_install() {
	elisp-install emms *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50emms-gentoo.el
	dodoc AUTHORS ChangeLog FAQ README RELEASE
	doinfo *.info*
	dobin *-wrapper emms-print-metadata
}
