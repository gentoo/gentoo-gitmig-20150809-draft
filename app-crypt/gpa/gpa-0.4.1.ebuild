# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.4.1.ebuild,v 1.1 2001/10/05 11:48:23 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GUI for GnuPG"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${A}"
HOMEPAGE="http://www.gnupg.org/gpa.html"

DEPEND=">=x11-libs/gtk+-1.2.1
	nls? ( sys-devel/gettext )"


src_compile() {
    local myconf

    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi

    ./configure --host=${CHOST} --prefix=/usr				\
		--sysconfdir=/etc $myconf || die
    emake || die
}

src_install () {
    make DESTDIR=${D} install || die

    dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}





