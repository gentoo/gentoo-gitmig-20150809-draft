# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joshua Pierre <joshua@swool.com>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam-oss/fam-oss-2.6.4.ebuild,v 1.2 2001/12/02 05:07:28 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="fam, the File Alteration Monitor."
SRC_URI=ftp://oss.sgi.com/projects/fam/download/${P}.tar.gz""
HOMEPAGE="http://oss.sgi.com/projects/fam/"

DEPEND=">=sys-devel/perl-5.6.1"

RDEPEND=">=net-nds/portmap-5b-r6"


src_unpack() {

	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var/lib
		    
	emake || die 
}

src_install() {

	make DESTDIR=${D} \
		install || die
	     
	exeinto /etc/init.d
	doexe ${FILESDIR}/fam
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS TODO README*
}
