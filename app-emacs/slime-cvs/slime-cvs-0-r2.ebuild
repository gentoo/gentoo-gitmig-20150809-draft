# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime-cvs/slime-cvs-0-r2.ebuild,v 1.2 2004/08/30 23:34:48 dholm Exp $

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
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp"

S="${WORKDIR}/slime"

CLPACKAGE=swank

src_compile() {
	echo "(add-to-list 'load-path \".\")" >script
	emacs --batch -q -l script -f batch-byte-compile hyperspec.el slime.el || die
}

src_install() {
	elisp-install ${PN} hyperspec.el slime.el slime.elc ${FILESDIR}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc README* ChangeLog
	zcat ${D}/usr/share/doc/${PF}/ChangeLog.gz > ${D}/usr/share/emacs/site-lisp/slime-cvs/ChangeLog
	insinto /usr/share/common-lisp/source/swank
	doins *.lisp ${FILESDIR}/swank.asd ChangeLog # required at runtime
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
	while read line; do einfo "${line}"; done <<EOF

SLIME notes for Gentoo
----------------------

If you're interested in hacking this ebuild, slime-cvs uses its own
swank.asd system definition file and swank-loader.lisp.

As always with CVS ebuilds, DO NOT report problems to upstream.
Always report problems to the Gentoo Bugzilla at
http://bugs.gentoo.org.

Matthew Kennedy <mkennedy@gentoo.org>

EOF
}
