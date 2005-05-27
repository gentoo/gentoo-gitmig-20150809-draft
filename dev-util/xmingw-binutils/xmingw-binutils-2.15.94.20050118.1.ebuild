# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-binutils/xmingw-binutils-2.15.94.20050118.1.ebuild,v 1.1 2005/05/27 17:32:05 cretin Exp $

inherit eutils

MY_P=binutils-2.15.94-20050118-1
S=${WORKDIR}/${MY_P}

DESCRIPTION="Tools necessary to build Win32 programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://sourceforge/mingw/${MY_P}-src.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	./configure \
		--target=i386-mingw32msvc \
		--prefix=/opt/xmingw || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
