# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r12.ebuild,v 1.16 2007/06/02 18:28:26 lavajoe Exp $

inherit flag-o-matic eutils toolchain-funcs

JUMBOV=20050501
DESCRIPTION="An interactive image manipulation program for X, supporting a wide variety of image formats"
HOMEPAGE="http://www.trilon.com/xv/index.html http://www.sonic.net/~roelofs/greg_xv.html"
SRC_URI="mirror://sourceforge/png-mng/${P}-jumbo-patches-${JUMBOV}.tar.bz2 ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz"

LICENSE="xv"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc-macos ppc64 sparc x86 ~x86-fbsd"
IUSE="jpeg tiff png"

DEPEND="|| ( x11-libs/libXt virtual/x11 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.6.1-r2 )
	png? ( >=media-libs/libpng-1.2 >=sys-libs/zlib-1.1.4 )"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}

	# bug #109012
	cd ${WORKDIR}; epatch ${FILESDIR}/jumbo-patch-nojpeg.diff || die

	cd ${S}

	# XXX: fix version on subsequent releases.
	epatch ${WORKDIR}/${P}-jumbo-fix-patch-20050410.txt || die
	epatch ${WORKDIR}/${P}-jumbo-enh-patch-${JUMBOV}.txt || die

	# OSX and BSD xv.h define patches
	epatch "${FILESDIR}/${P}"-osx-bsd.patch || die

	# OSX malloc patch
	epatch "${FILESDIR}/${P}"-vdcomp-osx.patch || die

	sed -i	-e 's/\(^JPEG.*\)/#\1/g' \
			-e 's/\(^PNG.*\)/#\1/g' \
			-e 's/\(^TIFF.*\)/#\1/g' \
			-e 's/\(^LIBS = .*\)/\1 $(LDFLAGS) /g' Makefile

	# /usr/bin/gzip => /bin/gzip
	sed -i	-e 's#/usr\(/bin/gzip\)#\1#g' config.h

	# fix installation of ps docs.
	sed -i -e 's#$(DESTDIR)$(LIBDIR)#$(LIBDIR)#g' Makefile
}

src_compile() {
	append-flags -DUSE_GETCWD -DLINUX -DUSLEEP

	einfo "Enabling Optional Features..."
	if use jpeg; then
		ebegin "	jpeg"
			append-flags -DDOJPEG
			append-ldflags -ljpeg
		eend
	fi
	if use png; then
		ebegin "	png"
			append-flags -DDOPNG
			append-ldflags -lz -lpng
		eend
	fi
	if use tiff; then
		ebegin "	tiff"
			append-flags -DDOTIFF -DUSE_TILED_TIFF_BOTLEFT_FIX
			append-ldflags -ltiff
		eend
	fi
	einfo "done."

	emake CC="$(tc-getCC)" CCOPTS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	emake	DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANDIR=/usr/share/man/man1 \
			LIBDIR=${T} install || die

	dodoc README{,.jumbo,.pcd} CHANGELOG BUGS IDEAS docs/*.ps docs/*.doc
}
