# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>, Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1-r2.ebuild,v 1.3 2001/10/06 17:04:49 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --bindir=/bin ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info bindir=${D}/bin install || die
	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib
	cd usr/bin
	ln -s ../../bin/* .
	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS
	else
		rm -rf ${D}/usr/share
	fi
}

