# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fcron/fcron-1.1.1.ebuild,v 1.2 2001/08/11 04:42:31 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A replacement for vcron"

SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"
HOMEPAGE="http://fcron.free.fr/"

DEPEND="virtual/glibc
        virtual/mta"


src_compile() {
    if [ ! -d "/etc/fcron" ]; then
        mkdir /etc/fcron
    fi

    try ./configure --prefix=/usr --host=${CHOST} \
        --with-etcdir=/etc/fcron \
        --with-piddir=/var/run \
        --with-spooldir=/var/spool/fcron \
        --with-sendmail=/usr/sbin/sendmail \
        --with-username=cron \
        --with-groupname=cron \
        --with-cflags="${CFLAGS}"

    try emake
}

src_install() {
    dodir /etc/fcron
    dodir /usr/bin
    dodir /usr/sbin
    dodir /usr/share/man{1,8}
    dodir /var/spool/fcron

    fperms 0770 /var/spool/fcron
    fowners root.cron /var/spool/fcron
    
    insinto /usr/bin
    insopts -o cron -g cron -m 6111
    doins fcrontab

    insopts -o root -g root -m 6111
    doins fcronsighup

    insinto /usr/sbin
    insopts -o root -g root -m 0110
    doins fcron

    dodoc MANIFEST VERSION

    cd ${S}/files
    insinto /etc/fcron
    insopts -m 0640 -o root -g cron
    doins fcron.conf fcron.allow fcron.deny

    cd ${S}/doc
    doman *.{1,8}
    dodoc CHANGES README LICENSE

    docinto html
    dodoc *.html

    insinto /etc/rc.d/init.d
    insopts -m 0755
    doins ${FILESDIR}/fcron
}
