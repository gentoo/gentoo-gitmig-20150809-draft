# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kobodeluxe/kobodeluxe-0.4_pre6.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

IUSE="opengl"

DESCRIPTION="An SDL port of xkobo, a addictive space shoot-em-up"
HOMEPAGE="http://olofson.net/skobo/"
KEYWORDS="x86"
LICENSE="GPL-2"

P=${P/_/-}
SRC_URI="http://olofson.net/download/${P}.tar.bz2"

RDEPEND="virtual/glibc
		media-libs/libsdl
		media-libs/sdl-image
		opengl? ( virtual/opengl )"
DEPEND="$RDEPEND
		>=sys-apps/sed-4
		sys-devel/autoconf"

SLOT=0

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix paths
	sed -i \
		-e 's/\$(datadir)\/games\/kobo-deluxe/$(datadir)\/games\/kobodeluxe/' \
		-e 's/\$(prefix)\/games\/kobo-deluxe\/scores/$(localstatedir)\/lib\/games\/kobodeluxe/' \
		configure
	chmod +x configure
}

src_compile() {
	#These do not work with the gentoo versions of oss and alsa,
	#but sound still works. Hmmm.
	#use oss    && myconf="$myconf --enable-oss"
	#use alsa   && myconf="$myconf --enable-alsa"

	./configure \
		`use_enable opengl` \
		--host=${CHOST} \
		--prefix=/usr \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make install DESTDIR=${D}

	dodoc README* TODO || die "dodoc failed"

	insinto /var/lib/games/kobodeluxe
	doins 42 || die "doins failed"

	# Fix perms
	DIROPTIONS="-g games -m 0775" dodir /var/lib/games/kobodeluxe

	# Fix dir name
	cd ${D}/usr/share/games
	mv kobo-deluxe kobodeluxe
}
