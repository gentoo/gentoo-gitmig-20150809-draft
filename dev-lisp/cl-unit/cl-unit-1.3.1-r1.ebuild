# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-unit/cl-unit-1.3.1-r1.ebuild,v 1.7 2007/02/03 17:49:57 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="A regression suite library for Common Lisp"
HOMEPAGE="http://www.ancar.org/CLUnit/docs/CLUnit.html http://packages.debian.org/unstable/devel/cl-unit.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/cl-unit_${PV}-${DEB_PV}.diff.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=clunit

src_unpack() {
	unpack ${A}
	epatch cl-unit_${PV}-${DEB_PV}.diff || die
	epatch ${FILESDIR}/${PV}-no-self-tests-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/clunit.asd
	common-lisp-system-symlink
	dodoc license readme
	dohtml docs/*
	do-debian-credits
}
