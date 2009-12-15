# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-with/cl-with-20020712.ebuild,v 1.2 2009/12/15 19:38:28 ssuominen Exp $

inherit common-lisp eutils

DESCRIPTION="With -- The Bastard Son of Loop"
HOMEPAGE="http://common-lisp.net/"
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
