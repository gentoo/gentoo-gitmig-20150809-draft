# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime-cvs/slime-cvs-0.ebuild,v 1.6 2004/06/30 02:48:54 agriffis Exp $

ECVS_SERVER="common-lisp.net:/project/slime/cvsroot"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="FAIRLY-STABLE"
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
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller"

S="${WORKDIR}/slime"

CLPACKAGE=swank

# TODO: ilisp and slime both provide a hyperspec.el.  Erik Naggum's
# hyperspec.el doesn't seem to be accessible anymore, but it would be
# best to compare differences and provide app-emacs/hyperspec

src_compile() {
	elisp-comp hyperspec.el slime.el 2>/dev/null || die
}

src_install() {
	elisp-install ${PN} hyperspec.el slime.el slime.elc ${FILESDIR}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc README* ChangeLog
	insinto /usr/share/common-lisp/source/swank
	# ChangeLog is needed at compile time!!
	doins *.lisp ${FILESDIR}/swank.asd ChangeLog
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/swank/swank.asd \
		/usr/share/common-lisp/systems
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
	elisp-site-regen
}

pkg_postinst() {
	/usr/sbin/register-common-lisp-source $CLPACKAGE
	elisp-site-regen
}
