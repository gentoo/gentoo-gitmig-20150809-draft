# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openquicktime/openquicktime-1.0.ebuild,v 1.12 2003/03/06 21:23:38 mholzer Exp $

inherit flag-o-matic
replace-flags "-fprefetch-loop-arrays" " "

MY_P=${P}-src
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenQuicktime library for linux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
HOMEPAGE="http://openquicktime.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc ~alpha"

DEPEND="media-sound/lame
	media-sound/mpg123
	media-libs/jpeg"

src_compile() {
	
	./configure \
		--enable-debug=no \
		--prefix=/usr || die # Disable debug - enabled by default
		
	make || die
}

src_install() {
	cd ${S}-src
	dolib.so libopenquicktime.so
	dodoc README AUTHORS NEWS COPYING TODO
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc \
		install || die
}
