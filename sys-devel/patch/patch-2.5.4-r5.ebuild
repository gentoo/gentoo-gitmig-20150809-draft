# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.4-r5.ebuild,v 1.2 2003/05/15 22:12:00 msterret Exp $

IUSE="build"

S=${WORKDIR}/${P}
DESCRIPTION="Utility to apply diffs to files"
SRC_URI="ftp://ftp.gnu.org/gnu/patch/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

src_compile() {
	CFLAGS="$CFLAGS -DLINUX -D_XOPEN_SOURCE=500"
	ac_cv_sys_long_file_names=yes \
		./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
	if [ -z "`use static`" ]; then
		emake || die "emake failed"
	else
		emake LDFLAGS=-static || die "emake failed"
	fi
}

src_install() {
	einstall
	if [ -z "`use build`" ]; then
		dodoc AUTHORS COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/man
	fi
}
