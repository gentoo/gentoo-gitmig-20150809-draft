# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-prevalence/cl-prevalence-20060521.ebuild,v 1.1 2006/05/21 06:50:42 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CL-PREVALENCE is an implementation of Object Prevalence for Common Lisp."
HOMEPAGE="http://www.common-lisp.net/project/cl-prevalence/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-s-xml
	dev-lisp/cl-s-sysdeps"

S=${WORKDIR}/${P}

CLPACKAGE=cl-prevalence

src_unpack() {
	unpack ${A}
	test -f ${S}/Makefile && rm -f ${S}/Makefile
#	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	dodir /usr/share/common-lisp/source/${CLPACKAGE}
	dodir /usr/share/common-lisp/systems
	cp -R src test ${D}/usr/share/common-lisp/source/${CLPACKAGE}/
	common-lisp-install ${CLPACKAGE}.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/${CLPACKAGE}/${CLPACKAGE}.asd \
		/usr/share/common-lisp/systems/
}
