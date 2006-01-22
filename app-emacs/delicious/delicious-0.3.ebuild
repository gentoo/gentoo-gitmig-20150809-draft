# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/delicious/delicious-0.3.ebuild,v 1.1 2006/01/22 22:45:16 wrobel Exp $

inherit elisp

DESCRIPTION="Emacs client API for del.icio.us"
HOMEPAGE="http://www.wjsullivan.net/delicious-el.html"
SRC_URI="http://www.wjsullivan.net/darcs/delicious-el/delicious-el-${PV}.tar.gz"

LICENSE="GPL-2"
IUSE="planner"
KEYWORDS="~x86"

SLOT="0"

DEPEND="
app-editors/emacs-cvs
planner? ( app-emacs/planner )"

SITEFILE=50delicious-gentoo.el

S="${WORKDIR}/${PN}-el"

src_compile() {

	cd ${S}

	local LOADPATH="/usr/share/emacs/22.0.50/lisp"
	LOADPATH="${LOADPATH}:${S}"

	if use planner; then
		LOADPATH="${LOADPATH}:/usr/share/emacs/site-lisp/planner"
		LOADPATH="${LOADPATH}:/usr/share/emacs/site-lisp/muse"
	fi

	local FILES="delicioapi.el delicious.el"
	use planner && FILES="${FILES} planner-delicious.el"

	EMACSLOADPATH="${LOADPATH}" elisp-compile ${FILES} || die
}

src_install() {

	cd ${S}

	dodoc README

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
