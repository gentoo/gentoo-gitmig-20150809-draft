# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xpaint/xpaint-2.7.0.ebuild,v 1.11 2006/02/04 09:51:53 nelchael Exp $

inherit eutils

DESCRIPTION="XPaint is an image editor which supports most standard paint program options."
SRC_URI="mirror://sourceforge/sf-xpaint/${P}.tar.bz2"
HOMEPAGE="http://sf-xpaint.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXp
		!Xaw3d? ( x11-libs/libXaw ) )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/imake
		x11-misc/gccmakedep
		app-text/rman )
	virtual/x11 )
	>=media-libs/tiff-3.2
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch || die "epatch failed"
}

src_compile() {
	xmkmf -a || die
	# It demands Xaw95 libs now even if the docs
	# say somthing else (own version is included)
	make xaw95static || die
}

src_install() {
	# make install causes tons of sanbox violations
	# even if it uses DESTDIR so we do it the hard way

	insinto /etc/X11/app-defaults
	doins app-defaults/out/*

	dobin xpaint

	insinto /usr/share/xpaint/help
	doins share/help/*
	insinto /usr/share/xpaint/messages
	doins share/messages/*
	insinto /usr/share/xpaint/filters
	doins share/filters/*
	insinto /usr/share/xpaint/include
	doins image.h

	insinto /usr/share/pixmaps
	doins XPaintIcon.xpm

	newman xpaint._man xpaint.1

	dodoc ChangeLog INSTALL README README.PNG README.old TODO \
	      Doc/Operator.doc Doc/sample.Xdefaults
}
