# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-binutils/xmingw-binutils-2.15.90.0.2.ebuild,v 1.4 2005/02/07 19:24:01 blubb Exp $

inherit eutils

MY_P=${P/xmingw-/}
S=${WORKDIR}/${MY_P}
MINGW_PATCH=binutils-2.15.90-20040222-1-src.diff.gz

DESCRIPTION="Tools necessary to build Win32 programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://kernel/linux/devel/binutils/${MY_P}.tar.bz2
		mirror://sourceforge/mingw/${MINGW_PATCH}"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	epatch "${DISTDIR}/${MINGW_PATCH}"
}

src_compile() {
	./configure \
		--target=i386-mingw32msvc \
		--prefix=/opt/xmingw || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
