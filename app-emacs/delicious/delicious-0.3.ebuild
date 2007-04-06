# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/delicious/delicious-0.3.ebuild,v 1.2 2007/04/06 10:25:18 opfer Exp $

inherit elisp

DESCRIPTION="Emacs client API for del.icio.us"
HOMEPAGE="http://www.wjsullivan.net/delicious-el.html"
SRC_URI="http://www.wjsullivan.net/darcs/delicious-el/delicious-el-${PV}.tar.gz"

LICENSE="GPL-2"
IUSE="planner"
KEYWORDS="~x86"

SLOT="0"

DEPEND="app-editors/emacs-cvs
planner? ( app-emacs/planner )"

SITEFILE=50delicious-gentoo.el

S="${WORKDIR}/${PN}-el"

src_compile() {
	local FILES="delicioapi.el delicious.el"
	use planner && FILES="${FILES} planner-delicious.el"
	elisp-comp ${FILES} || die "elisp-comp fails"
}

src_install() {

	cd "${S}"

	dodoc README

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
