# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-binutils/xmingw-binutils-2.14.90.0.6.ebuild,v 1.1 2003/10/02 10:15:30 cretin Exp $

DESCRIPTION="Tools necessary to build Win32 programs"

HOMEPAGE="http://sources.redhat.com/binutils/"

MINGW_PATCH=binutils-2.14.90-20030807-1-src.diff.gz

P=${P/xmingw-/}

SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
		mirror://sourceforge/mingw/${MINGW_PATCH}"
LICENSE="GPL-2 | LGPL-2"

SLOT="0"

KEYWORDS="x86"

IUSE=""

DEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}; gzip -dc ${DISTDIR}/${MINGW_PATCH} | patch -p1
}

src_compile() {
	./configure --target=i386-mingw32msvc --prefix=/opt/xmingw || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
