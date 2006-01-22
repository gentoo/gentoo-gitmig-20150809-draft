# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms/emms-1.0.20051204.ebuild,v 1.2 2006/01/22 01:15:07 marienz Exp $

inherit elisp

DESCRIPTION="EMMS is the Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/ http://www.emacswiki.org/cgi-bin/wiki/EMMS"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND="virtual/emacs"
DEPEND="${RDEPEND}
	sys-apps/texinfo"

# EMMS can use almost anything for playing media files therefore the dependency
# posibilities are so broad that we refrain from setting anything explicitly in
# DEPEND/RDEPEND.

S="${WORKDIR}/emms"

src_compile() {
	make EMACS=emacs DESTDIR=/usr/share/emacs/site-lisp/emms || die
}

src_install() {
	elisp-install emms *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50emms-gentoo.el
	dodoc AUTHORS README RELEASE
	doinfo *.info*
	dobin *-wrapper
}
