# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r4.ebuild,v 1.4 2001/10/06 16:51:30 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${P}.tar.gz ftp://ftp.gnu.org/gnu/diffutils/${P}.tar.gz"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

if [ -z "`use build`" ]
then
	DEPEND="$DEPEND sys-apps/texinfo"
fi

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --host=${CHOST} --prefix=/usr ${myconf} || die
	if [ "`use build`" ]
	then
		#disable texinfo building so we can remove the dep
		cp Makefile Makefile.orig
		sed -e 's/^all: ${PROGRAMS} info/all: ${PROGRAMS}/g' Makefile.orig > Makefile
	fi
	emake || die
}

src_install() {
	make prefix=${D}/usr infodir=${D}/usr/share/info install || die
	if [ -z "`use build`" ]
	then
		dodoc COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/info
	fi
}


