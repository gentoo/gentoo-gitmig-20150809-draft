# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-webactions/cl-webactions-1.2.35.20040924-r1.ebuild,v 1.1 2005/02/03 08:55:48 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:6}
CVS_PV=${PV:7:4}.${PV:11:2}.${PV:13}

DESCRIPTION="Webactions is Franz's library for dispatching HTTP requests as well as processing HTML templates."
HOMEPAGE="http://packages.debian.org/unstable/web/cl-webactions.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs.${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="=dev-lisp/cl-aserve-${PV}*"

CLPACKAGE=webactions

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs.${CVS_PV}

src_install() {
	common-lisp-install aserve/webactions/*.cl aserve/webactions/*.asd
	common-lisp-system-symlink
	insinto $CLSOURCEROOT/webactions/clpcode; doins aserve/webactions/clpcode/*.cl
	dohtml aserve/webactions/doc/*
	dodoc aserve/webactions/ChangeLog
	docinto examples
	dodoc contrib/*.lisp
	do-debian-credits
}
