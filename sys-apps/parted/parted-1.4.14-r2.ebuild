# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.4.14-r2.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="an advanced partition modification system"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${A}"
HOMEPAGE="http://www.gnu.org/software/${PN}"

RDEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.19-r2
	readline? ( >=sys-libs/readline-4.1-r2 )
	nls? ( sys-devel/gettext-0.10.38 )
	python? ( >=dev-lang/python-2.0 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

src_unpack() {
    unpack ${A}
    cd ${S}
    try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
	echo ">>> Running autoheader..."
	try autoheader
	echo ">>> Running libtoolize..."
	try libtoolize -c --force
	echo ">>> Running aclocal..."
    try aclocal
	echo ">>> Running autoconf..."
    try autoconf
	echo ">>> Running automake..."
    try automake
}

src_compile() {
    if [ "`use readline`" ]
    then
	myconf="${myconf} --with-readline"
    fi
    if [ "`use python`" ]
    then
	myconf="${myconf} --with-python"
    fi
    try PYTHON=/usr/bin/python ./configure --prefix=/usr --target=${CHOST} ${myconf}
    try make
}

src_install () {
    try make DESTDIR=${D} install
	if [ -z "`use bootcd`" ]
	then
		dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
		cd doc ; docinto doc
		dodoc API COPYING.DOC FAT USER USER.jp
	else
		rm -rf ${D}/usr/share/aclocal ${D}/usr/include
	fi
}
