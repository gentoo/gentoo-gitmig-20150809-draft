# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-csv/cl-csv-1.8.1.ebuild,v 1.3 2004/07/14 15:24:02 agriffis Exp $

inherit common-lisp

DESCRIPTION="CL-CSV is a Common Lisp library for importing CSV (Common Separated Values) formmated text files"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-csv"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-csv/cl-csv_${PV}.orig.tar.gz"
LICENSE="No-Problem-Bugroff"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=csv


src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
