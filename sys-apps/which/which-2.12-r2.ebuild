# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.12-r2.ebuild,v 1.3 2001/11/24 18:36:40 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Prints out location of specified executables that are in your path"
SRC_URI="ftp://prep.ai.mit.edu/gnu/which/${A}"

DEPEND="virtual/glibc sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try ./configure --prefix=/usr
    try make
}

src_install() {
    dobin which
    doman which.1
    doinfo which.info
    dodoc AUTHORS COPYING EXAMPLES NEWS README*
}

