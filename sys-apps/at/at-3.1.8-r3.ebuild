# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/at/at-3.1.8-r3.ebuild,v 1.2 2001/07/21 18:59:53 tadpol Exp $

A="${P}.tar.bz2 ${P}.dif"
S=${WORKDIR}/${P}
DESCRIPTION="queues jobs for later execution"
SRC_URI="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/${P}.tar.bz2
	 ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/${P}.dif"
HOMEPAGE=""

DEPEND="virtual/glibc >=sys-devel/flex-2.5.4a"

RDEPEND="virtual/glibc"

src_unpack() {

    unpack ${P}.tar.bz2
    cd ${S}
    patch -p0 < ${DISTDIR}/${P}.dif
    cp configure.in configure.orig
    patch -p0 < ${FILESDIR}/${P}-configure.in-sendmail-gentoo.diff
    patch -p0 < ${FILESDIR}/${P}-configure-sendmail-gentoo.diff
}

src_compile() {

    try ./configure --host=${CHOST/-pc/} --sysconfdir=/etc/at \
	--with-jobdir=/var/cron/atjobs \
	--with-atspool=/var/cron/atspool \
	--with-etcdir=/etc/at \
        --with-daemon_username=at \
        --with-daemon_groupname=at

    try pmake

}


src_install() {

	into /usr
	chmod 755 batch
	chmod 755 atrun
	dobin at batch
	fperms 4755 /usr/bin/at
	dosym at /usr/bin/atrm
	dosym at /usr/bin/atq
	dosbin atd atrun

	for i in atjobs atspool
	do
	  dodir /var/cron/${i}
 	  fperms 700 /var/cron/${i}
	  fowners at.at /var/cron/${i}
	  touch ${D}/var/cron/${i}/.SEQ
	done

	dodir /etc/rc.d/init.d
	cp ${FILESDIR}/atd ${D}/etc/rc.d/init.d/
	dodir /etc/at
 	cp ${FILESDIR}/at.deny ${D}/etc/at/

        doman at.1 at_allow.5 atd.8 atrun.8

	dodoc COPYING ChangeLog Copyright
	docinto txt
	dodoc Problems README

}



