# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-0.96.ebuild,v 1.1 2001/08/23 10:32:23 pm Exp $

S=${WORKDIR}/links-0.96
SRC_URI="http://artax.karlin.mff.cuni.cz/~mikulas/links/download/links-0.96.tar.gz"

HOMEPAGE="http://artax.karlin.mff.cuni.cz/~mikulas/links"

DESCRIPTION="A links like console-based web browser"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
        >=sys-libs/gpm-1.19.3
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
    local myconf
    if [ "`use ssl` " ]
    then
        myconf="--enable-ssl"
    else
	myconf="--disable-ssl"
    fi
    try ./configure --prefix=/usr --infodir=/usr/share/info \
	--mandir=/usr/share/man ${myconf}
    try make || die

}


src_install() {

    try make DESTDIR=${D} install || die

    dodoc README SITES NEWS AUTHORS COPYING BUGS TODO Changelog

}


