# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gai-pager/gai-pager-0.2.ebuild,v 1.1 2003/12/10 12:05:57 lordvan Exp $

MY_PV="${PV}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="This is an Enlightenment and a Waimea pager."
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/gai-0.5.0_pre6"

S=${WORKDIR}/${MY_P}

src_compile() {
	MY_CONF="--prefix=${D}/usr "
	econf ${MY_CONF} || die
	emake || die
}

src_install() {
	# small hack so the gnome picture gets installed in place
	mv ${S}/Makefile ${S}/Makefile.orig
	sed s%"GNOMEDIR = /usr"%"GNOMEDIR = ${D}/usr"% ${S}/Makefile.orig > ${S}/Makefile
	einstall || die
	dodoc BUGS COPYING CHANGES INSTALL README README.gaiTODO
}
