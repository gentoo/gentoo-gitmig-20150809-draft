# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/pdnsd/pdnsd-1.1.6.ebuild,v 1.2 2001/07/11 06:11:52 jerry Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Proxy DNS server with permanent caching"
SRC_URI="http://home.t-online.de/home/Moestl/${A}"
HOMEPAGE="http://home.t-online.de/home/Moestl/"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

#this service should be upgraded to offer optional supervise support

src_unpack() {
    unpack ${A}
}

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} \
        --sysconfdir=/etc/pdnsd --with-cachedir=/var/lib/pdnsd
    try make all
}

src_install() {
    try make DESTDIR=${D} install

    insinto /etc/rc.d/init.d
    insopts -m 0755
    doins ${FILESDIR}/pdnsd
}

# pdnsd should be manually configured before it's enabled.
#pkg_config() {
#    . ${ROOT}/etc/rc.d/config/functions
#    rc-update add pdnsd
#}
