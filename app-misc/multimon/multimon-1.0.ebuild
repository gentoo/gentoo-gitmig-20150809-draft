# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/multimon/multimon-1.0.ebuild,v 1.2 2001/08/11 04:42:31 drobbins Exp $

S=${WORKDIR}/multimon
SRC_URI="http://www.baycom.org/~tom/ham/linux/multimon.tar.gz"
HOMEPAGE="http://www.baycom.org/~tom/ham/linux/multimon.html"
DESCRIPTION="Multimon decodes digital transmission codes using OSS"
DEPEND="virtual/glibc virtual/x11"

src_compile() {
    try make CFLAGS="${CFLAGS}"
}

src_install() {
    local myarch
    myarch=`uname -m`
    dobin bin-${myarch}/gen bin-${myarch}/mkcostab bin-${myarch}/multimon

}
