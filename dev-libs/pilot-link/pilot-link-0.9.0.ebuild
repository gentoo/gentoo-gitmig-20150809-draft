# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pilot-link/pilot-link-0.9.0.ebuild,v 1.2 2001/06/08 01:08:06 achim Exp $

A=${PN}.${PV}.tar.gz
S=${WORKDIR}/${PN}.${PV}
DESCRIPTION="A pilot link librarie"
SRC_URI="http://www.slac.com/pilone/kpilot_home/download/${A}"
HOMEPAGE="http://www.slac.com/pilone/kpilot_home"

DEPEND="virtual/glibc"
src_unpack() {
    unpack ${A}
    patch -p0 <${FILESDIR}/${PF}-gentoo.diff
}
src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	--with-tcl=no --with-itcl=no --with-tk=no \
	--with-python=no --with-java=no --with-perl5=no
    try make

}

src_install () {

    try make prefix=${D}/usr mandir1=${D}/usr/share/man/man1 mandir7=${D}/usr/share/man/man7  install
    dodoc COPYING* ChangeLog README TODO 

}

