# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.5.6_pre20021105-r1.ebuild,v 1.6 2003/07/16 14:29:39 pvdabeel Exp $

DESCRIPTION="File transfer program to keep remote files into sync"
# remove -r1 from SRC_URI since it's the same source
SRC_URI="http://cvs.gentoo.org/~blizzy/${PF/-r1/}.tar.bz2"
HOMEPAGE="http://rsync.samba.org"
KEYWORDS="x86 ppc ~sparc alpha hppa"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
        !build? ( >=dev-libs/popt-1.5 )"
    
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
