# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-0.13.ebuild,v 1.6 2004/07/25 20:57:03 mkennedy Exp $

inherit elisp

DESCRIPTION="SLIME: The Superior Lisp Interaction Mode for Emacs"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2 | public-domain | LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=swank

src_compile() {
	echo "(add-to-list 'load-path \".\")" >script
	emacs --batch -q -l script -f batch-byte-compile hyperspec.el slime.el || die
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
	/usr/sbin/register-common-lisp-source ${CLPACKAGE}
	elisp-site-regen
	while read line; do einfo "${line}"; done <<EOF

SLIME notes for Gentoo
----------------------

Gentoo's port for SLIME uses its own swank.asd so that it fits more
cleanly into the Gentoo Common Lisp Controller framework.  For this
reason, DO NOT report problems to SLIME's upstream authors.	 Always
report problems to the Gentoo Bugzilla at http://bugs.gentoo.org
unless you are absolutely certain your problem it is not related to
the Gentoo port of SLIME.

Matthew Kennedy <mkennedy@gentoo.org>

EOF
}
