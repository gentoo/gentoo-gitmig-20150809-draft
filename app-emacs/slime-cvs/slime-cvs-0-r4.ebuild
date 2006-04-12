# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime-cvs/slime-cvs-0-r4.ebuild,v 1.2 2006/04/12 16:47:17 mkennedy Exp $

ECVS_SERVER="common-lisp.net:/project/slime/cvsroot"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi
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
	dev-lisp/common-lisp-controller
	virtual/commonlisp
	doc? ( virtual/tetex sys-apps/texinfo )"

S="${WORKDIR}/slime"

CLPACKAGE=swank

src_compile() {
	echo "(add-to-list 'load-path \".\")" >load-path
	emacs --batch -q -l load-path -f batch-byte-compile *.el || die
	use doc && make -C doc all slime.pdf
}

src_install() {
	elisp-install ${PN} *.{el,elc} ${FILESDIR}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc README* ChangeLog
	zcat ${D}/usr/share/doc/${PF}/ChangeLog.gz \
		>${D}/usr/share/emacs/site-lisp/slime-cvs/ChangeLog
	insinto /usr/share/common-lisp/source/swank
	doins *.lisp ${FILESDIR}/swank.asd
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/swank/swank.asd \
		/usr/share/common-lisp/systems
	if use doc; then
		dodoc doc/slime.{ps,pdf}
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
	zcat /usr/share/doc/${PF}/README.Gentoo |while read line; do einfo "${line}"; done
}
