# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <crux@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.4.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"


DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.3"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man --infodir=/usr/share/info
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING COPYRIGHT CREDITS ChangeLog README 
}
