# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-with/cl-with-20020712.ebuild,v 1.1 2005/10/01 07:07:09 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="With -- The Bastard Son of Loop"
HOMEPAGE="http://www.geocities.com/mparker762/with.html"
SRC_URI="mirror://gentoo/with-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-plus"

S=${WORKDIR}/

CLPACKAGE=with

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/with.asd
	common-lisp-system-symlink
	dodoc license.txt
}
