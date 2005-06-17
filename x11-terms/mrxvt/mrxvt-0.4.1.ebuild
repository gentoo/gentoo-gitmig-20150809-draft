# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mrxvt/mrxvt-0.4.1.ebuild,v 1.4 2005/06/17 20:27:53 hansmi Exp $

IUSE="debug truetype xgetdefault menubar"
#IUSE="${IUSE} utempter"

DESCRIPTION="Multi-tabbed rxvt clone with XFT, transparent background and CJK support"
HOMEPAGE="http://materm.sourceforge.net/"
SRC_URI="mirror://sourceforge/materm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~ppc-macos x86"

DEPEND="virtual/libc
	virtual/x11
	dev-libs/expat
	media-libs/libpng
	media-libs/jpeg
	truetype? ( virtual/xft
		media-libs/fontconfig
		media-libs/freetype )"
#	utempter? ( sys-apps/utempter )

src_compile() {
	local myconf

	# if you want to pass any other flags, use EXTRA_ECONF.
	if use linguas_el ; then
		myconf="${myconf} --enable-greek"
	fi
	if use linguas_ja ; then
		# --with-encoding=sjis
		myconf="${myconf} --enable-kanji --with-encoding=eucj"
	fi
	if use linguas_ko ; then
		myconf="${myconf} --enable-kr --with-encoding=kr"
	fi
	if use linguas_th ; then
		myconf="${myconf} --enable-thai"
	fi
	if use linguas_zh_CN ; then
		# --with-encoding=gbk
		myconf="${myconf} --enable-gb --with-encoding=gb"
	fi
	if use linguas_zh_TW ; then
		myconf="${myconf} --enable-big5 --with-encoding=big5"
	fi

	econf \
		--enable-everything \
		$(use_enable xgetdefault) \
		$(use_enable truetype xft) \
		$(use_enable debug) \
		$(use_enable menubar) \
		--disable-text-blink \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} docdir=/usr/share/doc/${PF} install || die

	gzip -9 ${D}/usr/share/doc/${PF}/*
	dodoc AUTHORS CREDITS ChangeLog FAQ NEWS README* TODO
}
