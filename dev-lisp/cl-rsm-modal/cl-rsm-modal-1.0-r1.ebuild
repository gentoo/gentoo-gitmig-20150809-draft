# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-modal/cl-rsm-modal-1.0-r1.ebuild,v 1.6 2007/02/03 17:45:14 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="R. Scott McIntire's Common Lisp Modal Logic Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-modal.html"
SRC_URI="mirror://gentoo/cl-rsm-modal_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-plus"

CLPACKAGE=rsm-modal

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-defconstant-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
