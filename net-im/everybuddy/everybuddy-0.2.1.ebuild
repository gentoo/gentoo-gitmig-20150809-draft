# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens  <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/everybuddy/everybuddy-0.2.1.ebuild,v 1.1 2001/05/24 04:31:09 blutgens Exp $

A=everybuddy-0.2.1beta3.tar.gz
S=${WORKDIR}/everybuddy-0.2.1beta3
DESCRIPTION="Universal Instant Messaging Client"
SRC_URI="http://www.everybuddy.com/files/${A}"
HOMEPAGE="http://www.everybuddy.com/"

DEPEND="virtual/glibc >=x11-libs/gtk+-1.2.10
	"


src_compile() {
   local myconf
   if [ -z "`use arts`" ]; then
        myconf="--disable-arts"
    fi

    try ./configure --prefix=/usr --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS NEWS README TODO COPYING ChangeLog
 
}
