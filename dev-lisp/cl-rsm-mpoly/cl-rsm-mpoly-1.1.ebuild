# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-mpoly/cl-rsm-mpoly-1.1.ebuild,v 1.4 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Multivariate Polynomial Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-mpoly.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-mpoly/cl-rsm-mpoly_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-filter"

CLPACKAGE=rsm-mpoly

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
