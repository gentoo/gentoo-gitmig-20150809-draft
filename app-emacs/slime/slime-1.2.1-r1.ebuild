# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-1.2.1-r1.ebuild,v 1.3 2005/08/04 08:54:16 mkennedy Exp $

inherit elisp cvs eutils

# MY_PV_CVS=${PV:4:4}-${PV:8:2}-${PV:10:2}
# MY_PV_BASE=${PV:0:3}

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"

# SRC_URI="http://www.common-lisp.net/project/slime/slime-${MY_PV_BASE}.tar.gz
#	mirror://gentoo/slime-${MY_PV_BASE}-CVS-${MY_PV_CVS}-gentoo.patch.bz2"
SRC_URI="http://common-lisp.net/project/slime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp
	doc? ( sys-apps/texinfo )"

CLPACKAGE=swank

src_unpack() {
	unpack ${A}
#	epatch slime-${MY_PV_BASE}-CVS-${MY_PV_CVS}-gentoo.patch || die
}

src_compile() {
	elisp-comp *.el || die
	use doc && make -C doc slime.info
}

src_install() {
	elisp-install ${PN} *.{el,elc} ${FILESDIR}/${PV}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/${PV}/70slime-gentoo.el
	dodoc README* ChangeLog
	zcat ${D}/usr/share/doc/${PF}/ChangeLog.gz \
		>${D}/usr/share/emacs/site-lisp/slime/ChangeLog
	insinto /usr/share/common-lisp/source/swank
	doins *.lisp ${FILESDIR}/${PV}/swank.asd
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/swank/swank.asd \
		/usr/share/common-lisp/systems
	if use doc; then
		doinfo doc/slime.info
	fi
}

pkg_preinst() {
	unregister-common-lisp-source $CLPACKAGE || die
}

pkg_postrm() {
	if ! [ -d /usr/share/common-lisp/source/$CLPACKAGE ]; then
		unregister-common-lisp-source $CLPACKAGE || die
	fi
	elisp-site-regen || die
}

pkg_postinst() {
	register-common-lisp-source $CLPACKAGE || die
	elisp-site-regen || die
	while read line; do einfo "${line}"; done <${FILESDIR}/${PV}/README.Gentoo
}
