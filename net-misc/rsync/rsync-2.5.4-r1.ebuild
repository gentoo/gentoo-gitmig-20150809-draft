# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org> 
# /space/gentoo/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.5.4.ebuild,v 1.1 2002/03/16 04:35:42 blocke Exp

S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="http://rsync.samba.org/ftp/rsync/${P}.tar.gz"
HOMEPAGE="http://rsync.samba.org"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# change confdir to /etc/rsync rather than just /etc (the --sysconfdir 
	# configure option doesn't work
	cp rsync.h rsync.h.orig
	sed -e 's:RSYNCD_CONF "/etc/rsyncd.conf":RSYNCD_CONF "/etc/rsync/rsyncd.conf":g' rsync.h.orig > rsync.h

	# yes, updating the man page is very important.
	cp rsyncd.conf.5 rsyncd.conf.5.orig
	sed -e 's:/etc/rsyncd:/etc/rsync/rsyncd:g' rsyncd.conf.5.orig > rsyncd.conf.5
} 

src_compile() {
	./configure --prefix=/usr --host=${CHOST} --with-included-popt || die
	if [ "`use static`" ] ; then
		emake LDFLAGS="-static" || die
	else
		emake || die
	fi
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install  || die
	if [ -z "`use build`" ]
	then
		dodir /etc/rsync
		dodoc COPYING NEWS OLDNEWS README TODO tech_report.tex
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postinst() {
	if [ ! -d /etc/rsync ]
	then
		mkdir /etc/rsync
	fi
}
