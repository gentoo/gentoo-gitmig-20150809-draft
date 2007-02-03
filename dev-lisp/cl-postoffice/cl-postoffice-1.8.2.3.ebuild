# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-postoffice/cl-postoffice-1.8.2.3.ebuild,v 1.6 2007/02/03 17:40:34 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Franz's SMTP, POP, & IMAP interface library for Common Lisp Programs"
HOMEPAGE="http://opensource.franz.com/postoffice/index.html
	http://packages.debian.org/unstable/devel/cl-postoffice"
SRC_URI="mirror://gentoo/cl-postoffice_${PV}.orig.tar.gz
	mirror://gentoo/cl-postoffice_${PV}-${DEB_PV}.diff.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-acl-compat"

CLPACKAGE=postoffice

# Invesitage why this doesn't work with CLISP sometime.

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc ChangeLog
	dohtml postoffice.html
}
