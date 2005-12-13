# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms-cvs/emms-cvs-0.ebuild,v 1.2 2005/12/13 16:11:48 mkennedy Exp $

ECVS_SERVER="cvs.savannah.gnu.org:/sources/emms"
ECVS_MODULE="emms"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi

inherit elisp cvs

DESCRIPTION="EMMS is the Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="virtual/emacs"

# EMMS can use almost anything for playing media files therefore the dependency
# posibilities are so broad that we refrain from setting anything explicitly in
# DEPEND/RDEPEND.

S="${WORKDIR}/emms"

src_compile() {
	make EMACS=emacs DESTDIR=/usr/share/emacs/site-lisp/emms-cvs || die
}

src_install() {
	elisp-install emms-cvs *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50emms-cvs-gentoo.el
	dodoc AUTHORS README RELEASE
	doinfo *.info*
	dobin *-wrapper
}
