# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Marko Mikulicic <marko@seul.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-0.4.ebuild,v 1.1 2002/06/21 20:19:30 rphillips Exp $

S=${WORKDIR}/${P}
SRC_URI="http://ftp.samba.org/ftp/distcc/${P}.tar.gz"
HOMEPAGE="http://ftp.samba.org/ftp/distcc/"
DESCRIPTION="a program to distribute compilation of C code across several machines
	over a network"
DEPEND="virtual/glibc"

src_compile() {
	./configure || die "config"
	emake -C src || die
}

src_install () {
	doins /usr
	dobin ${S}/src/distcc
	dobin ${S}/src/distccd
}



