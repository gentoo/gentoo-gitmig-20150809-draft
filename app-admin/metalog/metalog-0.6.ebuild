# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.6.ebuild,v 1.1 2001/07/11 06:45:34 jerry Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}

DESCRIPTION="A highly configurable replacement for syslogd/klogd"

SRC_URI="http://prdownloads.sourceforge.net/metalog/${A}"
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
    try ./configure --prefix=/usr
    try make
}

src_install () {
    try make DESTDIR=${D} install

    dodir /etc/metalog
    insinto /etc/metalog
    donewins metalog.conf metalog.conf.sample

    insinto /etc/rc.d/init.d
    insopts -m 0755
    doins ${FILESDIR}/metalog
}

# metalog should be manually configured before it's enbled.
#pkg_config() {
#    . ${ROOT}/etc/rc.d/config/functions
#    rc-update add metalog
#}
