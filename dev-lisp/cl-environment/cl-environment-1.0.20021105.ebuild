# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-environment/cl-environment-1.0.20021105.ebuild,v 1.4 2005/03/21 07:13:23 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:3}
CVS_PV=${PV:4:4}.${PV:8:2}.${PV:10}

DESCRIPTION="Provides an CLOS (CL Object System) encapsulation of the current CL implementation environment"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-environment"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-environment/cl-environment_${MY_PV}+cvs.${CVS_PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=environment

S=${WORKDIR}/cl-environment-${MY_PV}+cvs.${CVS_PV}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/environment.asd
	insinto ${CLSOURCEROOT}/${CLPACKAGE}/impl-dependent; doins impl-dependent/*.lisp
	common-lisp-system-symlink
	dodoc COPYING INSTALLATION README
}
