# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.5.5.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="http://rsync.samba.org/ftp/rsync/${P}.tar.gz"
HOMEPAGE="http://rsync.samba.org"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

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
	./configure --prefix=/usr --host=${CHOST} || die
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
