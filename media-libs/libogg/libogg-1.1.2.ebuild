# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.1.2.ebuild,v 1.2 2004/10/19 05:53:39 eradicator Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://downloads.xiph.org/releases/ogg/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa amd64 ~mips ~ia64 ~ppc64 ~macos ~ppc-macos"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gnuconfig_update
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	# remove the docs installed by make install, since I'll install
	# them in portage package doc directory
	rm -rf "${D}/usr/share/doc"

	dodoc AUTHORS CHANGES README
	dohtml doc/*.{html,png}
}
