# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-defsystem3/cl-defsystem3-3.3i-r4.ebuild,v 1.1 2004/08/01 22:34:54 mkennedy Exp $

inherit common-lisp-common

DEB_CVS=2004.07.18.1

DESCRIPTION="Another System Definition Facility for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-defsystem3.html"
# SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-defsystem3/${PN}_${PV}+cvs.${DEB_CVS}.tar.gz"
SRC_URI="mirror://gentoo/${PN}_${PV}+cvs.${DEB_CVS}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~mips"
IUSE=""

S=${WORKDIR}/${P}+cvs.${DEB_CVS}

src_unpack() {
	unpack ${A}
	mv ${S}/docs/defsystem.text ${S}/docs/defsystem.txt
}

src_install() {
	insinto /usr/share/common-lisp/source/defsystem
	doins defsystem.lisp
	dodoc ChangeLog README docs/defsystem.txt
	dohtml docs/defsystem.html
}

pkg_postinst() {
	reregister-all-common-lisp-implementations
}
