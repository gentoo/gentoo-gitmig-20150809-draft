# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.36.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
SRC_URI="mirror://sourceforge/zsnes/zsnes${PV//./}src.tar.gz"
HOMEPAGE="http://www.zsnes.com/"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"
IUSE="opengl"
SLOT="0"

RDEPEND="opengl? ( virtual/opengl )
	virtual/x11
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
}

src_compile() {
	# Don't attempt to introduce $CFLAGS usage, docs say result will be slower.
	cd ${S}/src
	econf `use_with opengl`
	emake || die "emake failed"
}

src_install() {
	cd ${S}/src
	into /usr
	dobin zsnes
	doman linux/zsnes.1
	cd ${S}
	dodoc *.txt linux/*
}
