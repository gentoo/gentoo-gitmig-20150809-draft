# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-1.9.ebuild,v 1.1 2001/06/05 16:31:49 michael Exp $

#P=
A=${P}.src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A graphical file comparator and merge tool simular to xdiff."
SRC_URI="http://prdownloads.sourceforge.net/xxdiff/${A}"
HOMEPAGE="http://xxdiff.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/qt-x11-2.3.0
	>=sys-devel/gcc-2.95.3"

RDEPEND="sys-apps/diffutils"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man
    try make
}

src_install () {
    dobin src/xxdiff
    newman src/xxdiff.man xxdiff.1
    dodoc README COPYING CHANGES ChangeLog copyright.txt doc/xxdiff-doc.sgml
}

# vim: ai et sw=4 ts=4
