# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-elephant/cl-elephant-0.2.1.ebuild,v 1.2 2005/03/21 07:12:11 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Elephant is an object database for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/elephant/"
SRC_URI="http://common-lisp.net/project/elephant/elephant-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	=sys-libs/db-4*
	dev-lisp/cl-uffi
	doc? ( sys-apps/texinfo )"

CLPACKAGE=elephant

S=${WORKDIR}/elephant-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_compile() {
	make CFLAGS="${CFLAGS}" || die
	if use doc; then
		cd doc; makeinfo elephant.texinfo || die
	fi
}

src_install() {
	insinto ${CLSOURCEROOT}/elephant/src
	doins src/*.lisp
	exeinto /usr/lib/elephant
	doexe libsleepycat.so
	common-lisp-install elephant.asd
	common-lisp-system-symlink
	dodoc CREDITS ChangeLog LICENSE NEWS NOTES README TODO TUTORIAL
	dohtml doc/html/*
	use doc && doinfo doc/elephant.info
}
