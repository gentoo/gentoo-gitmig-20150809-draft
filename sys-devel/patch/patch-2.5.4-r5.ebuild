# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.4-r5.ebuild,v 1.1 2003/05/14 02:24:33 msterret Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to apply diffs to files"
SRC_URI="ftp://ftp.gnu.org/gnu/patch/${A}"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

src_compile() {
	CFLAGS="$CFLAGS -DLINUX -D_XOPEN_SOURCE=500"; export CFLAGS
	ac_cv_sys_long_file_names=yes \
		./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
    if [ -z "`use static`" ]
    then
	    make ${MAKEOPTS} || die "make failed"
    else
        make ${MAKEOPTS} LDFLAGS=-static || die "make failed"
    fi
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || \
		die "make install failed"
    if [ -z "`use build`" ]
    then
	    dodoc AUTHORS COPYING ChangeLog NEWS README
    else
        rm -rf ${D}/usr/share/man
    fi
}
