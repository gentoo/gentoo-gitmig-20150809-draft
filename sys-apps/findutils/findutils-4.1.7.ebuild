# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.7.ebuild,v 1.2 2001/12/18 22:59:22 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://alpha.gnu.org/gnu/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

DEPEND="virtual/glibc sys-devel/gettext"
RDEPEND="virtual/glibc"


src_compile() {
	./configure --host=${CHOST} --prefix=/usr --localstatedir=/var/spool/locate || die
	emake libexecdir=/usr/lib/find || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info \
		localstatedir=/var/spool/locate libexecdir=${D}/usr/lib/find install || die
	dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
	rm -rf ${D}/usr/var
	if [ -z "`use build`" ] 
	then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
	dodir /var/spool/locate
	touch ${D}/var/spool/locate/.keep
}

