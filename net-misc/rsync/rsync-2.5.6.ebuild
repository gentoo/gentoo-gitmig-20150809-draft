# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.5.6.ebuild,v 1.5 2003/02/22 07:27:44 zwelch Exp $

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

KEYWORDS="x86 ~hppa arm"
SLOT="0"

SRC_URI="http://rsync.samba.org/ftp/rsync/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# change confdir to /etc/rsync rather than just /etc (the --sysconfdir
	# configure option doesn't work
	mv rsync.h rsync.h.orig
	sed <rsync.h.orig >rsync.h \
		-e 's|/etc/rsyncd.conf|/etc/rsync/rsyncd.conf|g'

	# yes, updating the man page is very important.
	mv rsyncd.conf.5 rsyncd.conf.5.orig
	sed <rsyncd.conf.5.orig >rsyncd.conf.5 \
		-e 's|/etc/rsyncd|/etc/rsync/rsyncd|g'
} 

src_compile() {
	if [ -n "$(use build)" ]; then
		POPTSETTING="--with-included-popt"
	else
		POPTSETTING=""
	fi
	./configure --prefix=/usr --host=${CHOST} ${POPTSETTING} || die
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
