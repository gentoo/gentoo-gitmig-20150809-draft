# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/pimpd/pimpd-0.8.ebuild,v 1.4 2002/08/01 11:59:03 seemant Exp $
# Updated to version 0.8 by Olivier Reisch on Fri Apr 26 11:44:26 CEST 2002

A=pimpd_0.8.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="pimpd is a (hopefully) RFC1413-compliant identd server supporting Linux 2.2.x masqueraded connections and Linux 2.4.x connection tracking for use with NAT."
SRC_URI="http://cats.meow.at/~peter/${A}"
HOMEPAGE="http://cats.meow.at/~peter/pimpd.html"
KEYWORDS="x86"
LICENSE="GPL"
SLOT="0"

src_compile() {
    make CFLAGS="$CFLAGS" || die
}

src_install () {

   dosbin pimpd
   dodoc README

}

