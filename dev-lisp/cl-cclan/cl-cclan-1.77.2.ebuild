# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-cclan/cl-cclan-1.77.2.ebuild,v 1.2 2004/06/24 23:42:09 agriffis Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="Comprehensive Common Lisp Archive Network"
HOMEPAGE="http://cclan.sourceforge.net
	http://www.cliki.net/cclan
	http://packages.debian.org/unstable/devel/cl-cclan.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-asdf/cl-asdf_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/cl-asdf
	virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=cclan

S=${WORKDIR}/cl-asdf-${PV}

src_install() {
	common-lisp-install cclan*.lisp cclan.asd
	common-lisp-system-symlink
}
