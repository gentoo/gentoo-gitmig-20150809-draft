# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-postoffice/cl-postoffice-1.8.2.3.ebuild,v 1.2 2005/04/11 08:05:47 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Franz's SMTP, POP, & IMAP interface library for Common Lisp Programs"
HOMEPAGE="http://opensource.franz.com/postoffice/index.html
	http://packages.debian.org/unstable/devel/cl-postoffice"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-postoffice/cl-postoffice_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-postoffice/cl-postoffice_${PV}-${DEB_PV}.diff.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-acl-compat"

S=${WORKDIR}/${PN}-${PV}

CLPACKAGE=postoffice

# Invesitage why this doesn't work with CLISP sometime.

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc ChangeLog
	dohtml postoffice.html
}
