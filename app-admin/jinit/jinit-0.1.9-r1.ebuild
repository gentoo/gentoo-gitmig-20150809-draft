# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/jinit/jinit-0.1.9-r1.ebuild,v 1.7 2002/08/13 20:18:16 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An alternative to sysvinit which supports the need(8) concept"
SRC_URI="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/download/${P}.tar.gz"
HOMEPAGE="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/
	http://www.atnf.csiro.au/~rgooch/linux/boot-scripts/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {

	econf || die
	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	mv ${D}/usr/sbin ${D}
	mv ${D}/sbin/init ${D}/sbin/jinit
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	cp -R example-setup ${D}/usr/share/doc/${PF}

	#find ${D}/usr/share/doc/${PF}/example-setup -name "Makefile*"
}
