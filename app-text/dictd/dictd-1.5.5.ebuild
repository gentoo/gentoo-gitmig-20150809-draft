# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.5.5.ebuild,v 1.2 2001/04/24 22:58:35 michael Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Dictionary Client/Server for the DICT protocol"
SRC_URI="ftp://ftp.dict.org/pub/dict/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35"


src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share \
        --with-etcdir=/etc/dict --host=${CHOST}
    try make
}

src_install () {
    # gotta set up the dirs for it....
    dodir /usr/bin
    dodir /usr/sbin
    dodir /usr/share/man1
    dodir /usr/share/man8

    #Now install it.
    try make prefix=${D}/usr man1_prefix=${D}/usr/share/man1 \
             man8_prefix=${D}/usr/share/man8 conf=${D}/etc/dict install

    #Install docs
    dodoc README TODO COPYING ChangeLog ANNOUNCE
    dodoc doc/dicf.ms doc/rfc.ms doc/rfc.sh doc/rfc2229.txt
    dodoc doc/security.doc doc/toc.ms

    #conf files.
    dodir /etc/dict
    insinto /etc/dict
    doins ${FILESDIR}/dict.conf
    doins ${FILESDIR}/dictd.conf
    doins ${FILESDIR}/site.info

    #startups for dictd
    exeinto /etc/rc.d/init.d
    newexe ${FILESDIR}/svc-dictd svc-dictd
    exeinto /var/lib/supervise/services/dictd
    newexe ${FILESDIR}/dictd-run run
}

pkg_postinst() {
    # gotta start it at boot.
    . ${ROOT}/etc/rc.d/config/functions
    einfo ">>>  Generating symlinks"
    ${ROOT}/usr/sbin/rc-update add svc-dictd
}

# vim: ai et sw=4 ts=4
