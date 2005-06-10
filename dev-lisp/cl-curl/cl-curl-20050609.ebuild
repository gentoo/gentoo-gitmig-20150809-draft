# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-curl/cl-curl-20050609.ebuild,v 1.1 2005/06/10 04:45:43 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp interface to libcurl, a multi-protocol file transfer library"
HOMEPAGE="http://sourceforge.net/projects/cl-curl/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-uffi
	net-misc/curl"

CLPACKAGE=curl

S=${WORKDIR}/curl

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	insinto $CLSOURCEROOT/${CLPACKAGE}/clcurl
	doins clcurl/*.c
	dodoc index.html style.css
}
