# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.6.ebuild,v 1.5 2001/11/10 02:30:19 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A highly configurable replacement for syslogd/klogd"

SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://metalog.sourceforge.net/"

DEPEND="virtual/glibc
        >=dev-libs/libpcre-3.4"


src_unpack() {
    cd ${WORKDIR}
    unpack ${A}
    cd ${S}/src

    mv metalog.h metalog.h.orig
    sed -e "s:/etc/metalog.conf:/etc/metalog/metalog.conf:g" \
        metalog.h.orig > metalog.h
}

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man
    try make
}

src_install () {
    try make DESTDIR=${D} install

    insinto /etc/metalog
    newins metalog.conf metalog.conf.sample

    exeinto /etc/rc.d/init.d
    newexe ${FILESDIR}/metalog.rc5 metalog

    dodoc AUTHORS COPYING ChangeLog README
    newdoc metalog.conf metalog.conf.sample
}
