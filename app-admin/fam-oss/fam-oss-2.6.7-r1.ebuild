# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joshua Pierre <joshua@swool.com>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam-oss/fam-oss-2.6.7-r1.ebuild,v 1.2 2002/06/02 04:06:49 prez Exp $

MY_P=${P/-oss/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="FAM, the File Alteration Monitor."
SRC_URI=ftp://oss.sgi.com/projects/fam/download/${MY_P}.tar.gz""
HOMEPAGE="http://oss.sgi.com/projects/fam/"

DEPEND=">=sys-devel/perl-5.6.1"

RDEPEND=">=net-nds/portmap-5b-r6"

src_unpack() {

	unpack ${A}

	cd ${S}
	# NOTE: dnotify patch for realtime updating, as well as build fixes
	patch -p1 < ${FILESDIR}/${PF}-gentoo.patch || die

	cp ${FILESDIR}/${PF}-aclocal.m4 aclocal.m4
	libtoolize --copy --force
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

