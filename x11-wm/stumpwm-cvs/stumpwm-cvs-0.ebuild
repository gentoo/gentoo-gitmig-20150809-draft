# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/stumpwm-cvs/stumpwm-cvs-0.ebuild,v 1.3 2007/08/29 15:28:03 hkbst Exp $

inherit common-lisp cvs eutils

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/stumpwm"

if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi

ECVS_MODULE="stumpwm"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP -z3"

DESCRIPTION="Stumpwm is a tiling, keyboard driven X11 Window Manager written entirely in Common Lisp."
HOMEPAGE="http://www.nongnu.org/stumpwm/index.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="sbcl clisp emacs doc"

CLPACKAGE="stumpwm"

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	doc? ( sys-apps/texinfo )"

# If clisp is selected, we need at least dev-lisp/clisp-2.38-r2

RDEPEND="${DEPEND}
	emacs? ( app-emacs/slime )
	!clisp? ( !sbcl? ( !amd64? ( dev-lisp/cmucl ) ) )
	clisp? ( >=dev-lisp/clisp-2.38-r2 )
	sbcl?  ( dev-lisp/sbcl dev-lisp/cl-clx )"

S=${WORKDIR}/${ECVS_MODULE}

pkg_setup() {
	if use clisp; then
		if built_with_use dev-lisp/clisp X; then
			if built_with_use dev-lisp/clisp new-clx; then
				while read line; do ewarn "$line"; done <<'EOF'
CLISP needs MIT-CLX support built-in to work with StumpWM. Your CLISP
has been built with support for NEW-CLX which may not work properly
with StumpWM.  Emerge dev-lisp/clisp with "X -new-clx" in USE.
EOF
			fi
		else
			die "You need to build dev-lisp/clisp with USE='X -new-clx'"
		fi
	fi
}

src_compile() {
	use doc && makeinfo stumpwm.texi
}

src_install() {
	common-lisp-install *.lisp stumpwm.asd
	common-lisp-system-symlink
	dodoc COPYING README NEWS ChangeLog ${FILESDIR}/README.Gentoo
	use doc && doinfo stumpwm.info
}

pkg_postinst() {
	common-lisp_pkg_postinst
	cat ${FILESDIR}/README.Gentoo
}
