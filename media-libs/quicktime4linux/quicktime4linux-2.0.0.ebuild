# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-2.0.0.ebuild,v 1.6 2004/07/14 20:24:34 agriffis Exp $

inherit flag-o-matic eutils

DESCRIPTION="quicktime library for linux"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 -ppc ~sparc ~amd64"
IUSE=""

DEPEND="media-libs/jpeg
	media-libs/libpng
	>=media-libs/libmpeg3-1.5.1
	!media-libs/libquicktime"
PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-libmpeg3.patch
#	epatch ${FILESDIR}/${PV}-gentoo-sharedlib.patch
#	[ "${ARCH}" == "ppc" ] && sed -i 's:-mno-ieee-fp::g' `find -name 'Makefile*' -o -name 'configure*'`
}

src_compile() {
#	append-flags -I${S}/libdv-0.98/libdv -I${S}/libdv-0.98
	make || die
	make util || die
}

src_install() {
	dolib.so `uname -m`/libquicktime.so
	dolib.a  `uname -m`/libquicktime.a
	insinto /usr/include/quicktime
	doins *.h
	dodoc README
	dohtml -r docs
}
