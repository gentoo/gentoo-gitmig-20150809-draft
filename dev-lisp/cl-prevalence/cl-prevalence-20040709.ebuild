# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-prevalence/cl-prevalence-20040709.ebuild,v 1.2 2004/07/14 16:00:30 agriffis Exp $

inherit common-lisp eutils

DESCRIPTION="CL-PREVALENCE is an implementation of Object Prevalence for Common Lisp."
HOMEPAGE="http://www.common-lisp.net/project/cl-prevalence/"
SRC_URI="mirrors://gentoo/cl-prevalence-20040709.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-s-xml"

S=${WORKDIR}/${PN}

CLPACKAGE=cl-prevalence

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	dodir /usr/share/common-lisp/source/cl-prevalence
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/cl-prevalence/
	common-lisp-install cl-prevalence.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/cl-prevalence/cl-prevalence.asd \
		/usr/share/common-lisp/systems/

}
