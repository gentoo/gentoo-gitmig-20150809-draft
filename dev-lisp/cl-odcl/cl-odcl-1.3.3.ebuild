# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-odcl/cl-odcl-1.3.3.ebuild,v 1.1 2003/06/19 03:16:02 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Commmon Lisp library of utility functions. This package contains a number of useful utility functions for Lisp developers.  Include are editing contexts, a transaction system, a filesystem database with indexing, a LRU cache algorithm, time functions, simple i18n/l10n, developer diagnostics, a test regression system, SMTP mailer, object property sets and utility functions related to lists, strings and numbers."
HOMEPAGE="http://alpha.onshored.com/lisp-software/#odcl"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-odcl/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=odcl

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	# some tests die on clisp
	cd ${S} && patch -p0 <${FILESDIR}/clisp-tests-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp odcl.asd
	common-lisp-system-symlink 
	insinto /usr/share/common-lisp/source/odcl/tests
	doins tests/*.lisp
	dodoc COPYING ChangeLog NEWS README VERSION
}
