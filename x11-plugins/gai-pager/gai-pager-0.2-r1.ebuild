# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gai-pager/gai-pager-0.2-r1.ebuild,v 1.4 2004/10/08 18:40:43 lordvan Exp $

MY_PV="${PV}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="This is an Enlightenment and a Waimea pager."
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=x11-libs/gai-0.5.0_pre6"

S=${WORKDIR}/${MY_P}

src_compile() {
#	MY_CONF="--prefix=${D}/usr "
	econf ${MY_CONF} || die
	mv ${S}/Makefile ${S}/Makefile.orig
	sed s%"IMAGE_PATH = \"\\\\\"\$.PREFIX./"%"IMAGE_PATH = \"\\\\\"/usr/"% ${S}/Makefile.orig > ${S}/Makefile
	emake || die
}

src_install() {
	# small hack so the gnome picture gets installed in place
	mv ${S}/Makefile ${S}/Makefile.orig
	sed s%"GNOMEDIR = /usr"%"GNOMEDIR = ${D}/usr"% ${S}/Makefile.orig | \
	sed s%"PREFIX = /usr"%"PREFIX = ${D}/usr"% > ${S}/Makefile
	dodir /usr
	einstall || die
	dodoc BUGS COPYING CHANGES INSTALL README README.gai TODO
}
