# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-org-davep-newsrc/cl-org-davep-newsrc-2.0.ebuild,v 1.3 2005/04/11 07:40:15 mkennedy Exp $

inherit common-lisp

DESCRIPTION='Common Lisp class for reading the Unix-style ~/.newsrc file'
HOMEPAGE="http://www.davep.org/lisp/"
SRC_URI="http://www.davep.org/lisp/org-davep-newsrc-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence"

CLPACKAGE=org-davep-newsrc

S=${WORKDIR}/${P#cl-}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
