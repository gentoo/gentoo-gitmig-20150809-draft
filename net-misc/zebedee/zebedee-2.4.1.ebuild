# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zebedee/zebedee-2.4.1.ebuild,v 1.2 2003/06/17 23:30:54 alron Exp $

DESCRIPTION="A simple, free, secure TCP and UDP tunnel program"
HOMEPAGE="http://www.winton.org.uk/zebedee/"
SRC_URI="http://www.winton.org.uk/zebedee/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
DEPEND=">=dev-libs/openssl-0.9.5a
    >=sys-libs/zlib-1.1.4
    >=sys-apps/bzip2-1.0.1"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	cp Makefile Makefile.orig
	patch -p0 < ${FILESDIR}/${P}-Makefile.patch || die
	mv zebedee.c zebedee.c.orig
	cat zebedee.c.orig | \
		sed "s/^#include \"blowfish\.h\"$/#include \"openssl\/blowfish\.h\"/g" \
		> zebedee.c
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README.txt LICENCE.txt GPL2.txt CHANGES.txt zebedee.html ftpgw.tcl.html zebedee.ja_JP.html
	exeinto /etc/init.d
	doexe ${FILESDIR}/zebedee
	dodir /etc/zebedee
	insinto /etc/zebedee
	doins server.zbd vncviewer.zbd vncserver.zbd
	newins server.id server.id.example
	insopts -m 600
	newins server.key server.key.example
	newins client1.key client1.key.example
	newins client2.key client2.key.example
	newins clients.id clients.id.example
}

pkg_postinst() {
	einfo
	einfo "Before you use the Zebedee rc script (/etc/init.d/zebedee), it is"
	einfo "recommended that you edit the server config file (/etc/zebedee/server.zbd)."
	einfo "the \"detached\" directive should remain set to false; the rc script takes"
	einfo "care of backgrounding automatically."
	einfo
}
