# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-series/cl-series-2.2.7.ebuild,v 1.1 2004/07/24 18:44:42 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp extension for general iteration"
HOMEPAGE="http://series.sf.net"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-series/cl-series_${PV}-${DEB_PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=series

S=${WORKDIR}/${PN#cl-}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-sbcl-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp series.asd
	common-lisp-system-symlink
	dodoc RELEASE-NOTES ChangeLog s-doc.txt
	do-debian-credits
}
