# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Maintainer Bart Verwilst <verwilst@gentoo.org>, Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/everybuddy/everybuddy-0.2.1-r2.ebuild,v 1.1 2002/02/09 11:47:56 verwilst Exp $

S=${WORKDIR}/everybuddy-0.2.1beta6
DESCRIPTION="Universal Instant Messaging Client"
SRC_URI="http://www.everybuddy.com/files/everybuddy-0.2.1beta6.tar.gz"
HOMEPAGE="http://www.everybuddy.com/"
SLOT="0"
DEPEND="virtual/glibc 
	>=x11-base/xfree-4.1.0
	>=x11-libs/gtk+-1.2.10-r4"


src_compile() {
    local myconf
    if [ -z "`use arts`" ]; then
        myconf="--disable-arts"
    fi

    ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die
    make || die

}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS NEWS README TODO COPYING ChangeLog

}


