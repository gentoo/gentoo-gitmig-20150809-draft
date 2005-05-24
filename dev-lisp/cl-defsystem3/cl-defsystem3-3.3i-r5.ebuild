# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-defsystem3/cl-defsystem3-3.3i-r5.ebuild,v 1.5 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp

DEB_CVS=2004.07.18.1

DESCRIPTION="Another System Definition Facility for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-defsystem3.html"
SRC_URI="mirror://gentoo/${PN}_${PV}+cvs.${DEB_CVS}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc x86"
IUSE=""

S=${WORKDIR}/${P}+cvs.${DEB_CVS}

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=defsystem

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
	mv ${S}/docs/defsystem.text ${S}/docs/defsystem.txt
}

src_install() {
	common-lisp-install defsystem.lisp ${FILESDIR}/defsystem.asd
	common-lisp-system-symlink
	dodoc ChangeLog README docs/defsystem.txt
	dohtml docs/defsystem.html
}
