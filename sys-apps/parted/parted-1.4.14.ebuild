# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.4.14.ebuild,v 1.3 2001/06/02 22:34:02 pete Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="an advanced partition modification system"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${A}"
HOMEPAGE="http://www.gnu.org/software/${PN}"

DEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.19-r2
	readline? ( sys-libs/readline-4.2 )
	nls? ( sys-devel/gettext-0.10.38-r2 )"

src_compile() {
    try ./configure --prefix=/usr --target=${CHOST}
    try make
}

src_install () {
    try make DESTDIR=${D} install
}

