# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.1_p1.ebuild,v 1.8 2003/09/06 08:39:20 msterret Exp $

S=${WORKDIR}/${P/_}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="http://ftp.cvshome.org/${P/"_p1"}/${P/_}.tar.gz
		 mirror://gentoo/cvs-1.11.1p1-extzlib.patch.bz2"
HOMEPAGE="http://www.cvshome.org/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.4"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc "


src_unpack() {

	unpack ${P/_}.tar.gz

	# Redhat's external zlib patch
	cd ${S}
	cp ${DISTDIR}/cvs-1.11.1p1-extzlib.patch.bz2 ${S}
	bunzip2 cvs-1.11.1p1-extzlib.patch.bz2
	patch -p1 < cvs-1.11.1p1-extzlib.patch

}

src_compile() {
	econf || die
	make || die
}

src_install() {

	einstall || die

	dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING
	dodoc MINOR* NEWS PROJECTS README* TESTS TODO
	mv ${D}/usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
	insinto /usr/share/emacs/site-lisp
	doins cvs-format.el
}
