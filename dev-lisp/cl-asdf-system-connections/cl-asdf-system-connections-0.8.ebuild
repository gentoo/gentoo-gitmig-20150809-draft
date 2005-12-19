# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-asdf-system-connections/cl-asdf-system-connections-0.8.ebuild,v 1.1 2005/12/19 22:05:54 mkennedy Exp $

inherit common-lisp

DESCRIPTION="ASDF-System-Connections provides auto-loading of systems that only make sense when several other systems are loaded."
HOMEPAGE="http://common-lisp.net/project/cl-containers/asdf-system-connections/"
SRC_URI="mirror://gentoo/${PN/cl-/}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN/cl-/}

CLPACKAGE=asdf-system-connections

src_install() {
	insinto $CLSOURCEROOT/$CLPACKAGE/dev
	doins dev/*.lisp
	common-lisp-install asdf-system-connections.asd
	common-lisp-system-symlink
}
