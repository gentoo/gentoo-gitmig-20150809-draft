# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam-oss/fam-oss-2.6.4-r1.ebuild,v 1.3 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="fam, the File Alteration Monitor."
SRC_URI=ftp://oss.sgi.com/projects/fam/download/${P}.tar.gz""
SLOT="0"
HOMEPAGE="http://oss.sgi.com/projects/fam/"

DEPEND=">=sys-devel/perl-5.6.1"

RDEPEND=">=net-nds/portmap-5b-r6"

src_unpack() {

	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die

	# Some patch I found in the SRPM, not sure what it's for
	patch -p1 < ${FILESDIR}/${P}-creds.patch || die

	# Patch that make FAM use dnotify which is present in 2.4 kernels
	patch -p1 < ${FILESDIR}/${P}-dnotify.patch || die
	libtoolize --force
	aclocal
	autoconf
	autoheader
	automake --add-missing
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
