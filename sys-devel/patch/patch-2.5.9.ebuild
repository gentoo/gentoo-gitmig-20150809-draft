# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.9.ebuild,v 1.4 2003/07/06 09:10:57 kumba Exp $

IUSE="build static"

S=${WORKDIR}/${P}
DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
SRC_URI="http://alpha.gnu.org/gnu/patch/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86 ~ppc sparc ~alpha mips ~hppa ~arm"

DEPEND="virtual/glibc"

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
