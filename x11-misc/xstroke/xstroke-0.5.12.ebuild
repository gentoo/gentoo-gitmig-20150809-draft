# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.5.12.ebuild,v 1.8 2003/02/17 00:32:42 liquidx Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Gesture/Handwriting recognition engine for X"
HOMEPAGE="http://www.east.isi.edu/projects/DSN/xstroke/"
SRC_URI="ftp://ftp.handhelds.org/pub/projects/${PN}/release-0.5/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=x11-base/xfree-4.1.0"

src_unpack() {
	unpack ${A}
	# generate Makefile from Imakefile
	cd ${S}; xmkmf -a
}

src_compile() {
	# otherwise it'll include the wrong freetype headers.
	make INCLUDES="-I/usr/include/freetype2" || die
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die
}

