# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-mod/cl-rsm-mod-1.2.ebuild,v 1.3 2004/07/14 16:05:18 agriffis Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Modular Arithmetic Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-mod.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-mod/cl-rsm-mod_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-mod

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
