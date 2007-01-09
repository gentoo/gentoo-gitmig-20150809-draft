# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime-cvs/slime-cvs-0-r6.ebuild,v 1.2 2007/01/09 13:01:48 opfer Exp $

ECVS_SERVER="common-lisp.net:/project/slime/cvsroot"
ECVS_BRANCH="HEAD"
ECVS_MODULE="slime"
ECVS_USER="anonymous"
ECVS_PASS="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND="virtual/emacs
	virtual/commonlisp
	doc? ( virtual/tetex sys-apps/texinfo )"

S="${WORKDIR}/slime"

CLPACKAGE=swank

src_compile() {
	elisp-comp *.el || die
	use doc && make -C doc slime.info
}

src_install() {
	elisp-install ${PN} *
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc README* ChangeLog HACKING NEWS PROBLEMS
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/emacs/site-lisp/${PN}/swank.asd \
		/usr/share/common-lisp/systems/
	if use doc; then
		doinfo doc/slime.info
	fi
}
