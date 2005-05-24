# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pxmlutils/cl-pxmlutils-0.0.9-r2.ebuild,v 1.7 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Portable version of Franz's xmlutils.	Includes XML and HTML parsers."
HOMEPAGE="http://www.common-lisp.net/project/bese/pxmlutils.html"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/pxmlutils/pxmlutils_${PV}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-acl-compat"

S=${WORKDIR}/pxmlutils_${PV}

CLPACKAGE=pxmlutils

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}
src_compile() {
	:
}

src_install() {
	common-lisp-install pxmlutils.asd *.cl
	common-lisp-system-symlink
	dodoc ChangeLog README *.{htm,txt}
}
