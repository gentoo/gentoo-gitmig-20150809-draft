# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-torta/cl-torta-0.3.ebuild,v 1.1 2006/07/23 21:22:28 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Torta shows you where your disk space is being used."
HOMEPAGE="http://bachue.com/svnwiki/torta"
SRC_URI="http://evilrobot.free.fr/torta/torta-${PV}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
DEPEND="dev-lisp/cl-gordon"

CLPACKAGE=torta

S=${WORKDIR}/torta

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-freeserif.fo-pathname-gentoo.patch
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc ChangeLog COPYING README
	insinto $CLSOURCEROOT/$CLPACKAGE/
	doins *.fo
}
