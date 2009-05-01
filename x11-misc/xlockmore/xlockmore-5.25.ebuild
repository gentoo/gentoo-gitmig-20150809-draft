# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xlockmore/xlockmore-5.25.ebuild,v 1.9 2009/05/01 17:44:52 armin76 Exp $

inherit pam

DESCRIPTION="Just another screensaver application for X"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"
SRC_URI="http://ftp.tux.org/pub/tux/bagleyd/${PN}/${P}/${P}.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="crypt debug nas esd motif opengl truetype gtk pam xlockrc unicode"

RDEPEND="opengl? ( media-libs/mesa )
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm
	media-libs/freetype
	pam? ( virtual/pam )
	nas? ( media-libs/nas )
	esd? ( media-sound/esound )
	motif? ( x11-libs/openmotif )
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xineramaproto"

src_compile() {
	econf --enable-appdefaultdir=/usr/share/X11/app-defaults \
		--enable-vtlock --without-ftgl --without-gltt \
		$(use_enable crypt) \
		$(use_with opengl) \
		$(use_with opengl mesa) \
		$(use_enable xlockrc) \
		$(use_enable unicode use-mb) \
		$(use_enable pam) \
		$(use_with truetype ttf) \
		$(use_with gtk gtk2) \
		$(use_with motif) \
		$(use_with esd esound) \
		$(use_with nas) \
		$(use_with debug editres)

	emake -j1 || die "emake failed"
}

src_install() {
	einstall xapploaddir="${D}/usr/share/X11/app-defaults" \
		mandir="${D}/usr/share/man/man1" INSTPGMFLAGS="" \
		|| die "einstall failed"

	pamd_mimic_system xlock auth
	use pam && fperms 755 /usr/bin/xlock

	dohtml docs/*.html
	rm docs/*.html
	dodoc README docs/*
}
