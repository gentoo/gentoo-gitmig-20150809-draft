# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.1.ebuild,v 1.14 2004/08/23 07:57:46 hardave Exp $

inherit gnuconfig

IUSE=""

DESCRIPTION="the Ogg media file format library"
SRC_URI="http://www.vorbis.com/files/1.0.1/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa amd64 mips ~ia64 ppc64"

src_compile() {
	#Needed for mips and probablly others
	gnuconfig_update

	econf || die "Configure failed."
	emake || die "Emake failed."
}

src_install () {
	make DESTDIR=${D} install || die

	# remove the docs installed by make install, since I'll install
	# them in portage package doc directory
	echo "Removing docs installed by make install"
	rm -rf ${D}/usr/share/doc

	dodoc AUTHORS CHANGES COPYING README
	dohtml doc/*.{html,png}
}

