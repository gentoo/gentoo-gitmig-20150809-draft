# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.52.ebuild,v 1.1 2001/12/21 15:15:32 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"

DEPEND=">=sys-devel/m4-1.4o-r2"

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --target=${CHOST} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING AUTHORS BUGS ChangeLog ChangeLog.0 ChangeLog.1 NEWS README TODO THANKS
}


