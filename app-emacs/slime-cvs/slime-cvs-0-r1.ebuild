# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime-cvs/slime-cvs-0-r1.ebuild,v 1.1 2004/01/26 18:10:54 mkennedy Exp $

ECVS_SERVER="common-lisp.net:/project/slime/cvsroot"
if [ -z "${ECVS_BRANCH}" ]; then # user configurable
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

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp"

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
	while read line; do einfo "${line}"; done <<EOF

SLIME notes for Gentoo
----------------------

You can elect to set the ECVS_BRANCH environment variable when
emerging slime-cvs.	 If unset, the default is to pull the
FAIRLY-STABLE tag. eg.

   ECVS_BRANCH=HEAD emerge slime-cvs

While this ebuild attempts to work for the FAIRLY-STABLE tag, it may
not always work with CVS HEAD.

If you're interested in hacking this ebuild, slime-cvs uses its own
swank.asd system definition file and swank-loader.lisp.

As always with CVS ebuilds, DO NOT report problems to upstream.
Always report problems to the Gentoo Bugzilla at
http://bugs.gentoo.org.

Matthew Kennedy <mkennedy@gentoo.org>

EOF
}
