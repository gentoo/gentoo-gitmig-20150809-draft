# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kobodeluxe/kobodeluxe-0.3-r1.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

IUSE="oss opengl"

S=${WORKDIR}/${P}

DESCRIPTION="An SDL port of xkobo, a addictive space shoot-em-up"
SRC_URI="http://olofson.net/skobo/download/${P}.tar.bz2"
HOMEPAGE="http://olofson.net/skobo/"
KEYWORDS="x86"
LICENSE="GPL-2"

SLOT=0
DEPEND="virtual/glibc
		sys-devel/autoconf
		media-libs/libsdl
		media-libs/sdl-image
		opengl? ( virtual/opengl )"
RDEPEND="virtual/glibc
		media-libs/libsdl
		media-libs/sdl-image
		opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix paths
	mv configure configure.orig
	sed -e 's/\$(datadir)\/games\/kobo-deluxe/$(datadir)\/games\/kobodeluxe/' \
		-e 's/\$(prefix)\/games\/kobo-deluxe\/scores/$(localstatedir)\/lib\/games\/kobodeluxe/' \
		configure.orig > configure
	chmod +x configure
}

src_compile() {
	local myconf

	use opengl && myconf="--enable-opengl"
	use oss    && myconf="$myconf --enable-oss"

	./configure \
		$myconf \
		--host=${CHOST} \
		--prefix=/usr \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodoc README* TODO
	dobin kobodl

	dodir /usr/share/games/kobodeluxe/gfx
	insinto /usr/share/games/kobodeluxe/gfx
	doins data/*.{pcx,png}

	DIROPTIONS="-g games -m 0775" dodir /var/lib/games/kobodeluxe
	insinto /var/lib/games/kobodeluxe
	doins 42
}
