# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mrxvt/mrxvt-0.4.2.ebuild,v 1.3 2006/04/16 22:33:53 hansmi Exp $

inherit eutils

IUSE="debug truetype xgetdefault menubar"
#IUSE="${IUSE} utempter"

DESCRIPTION="Multi-tabbed rxvt clone with XFT, transparent background and CJK support"
HOMEPAGE="http://materm.sourceforge.net/"
SRC_URI="mirror://sourceforge/materm/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~ppc-macos x86"

RDEPEND="dev-libs/expat
	media-libs/libpng
	media-libs/jpeg
	truetype? ( virtual/xft
		media-libs/fontconfig
		media-libs/freetype )
	|| ( (
			x11-libs/libX11
			x11-libs/libXt
			x11-libs/libXpm
			x11-libs/libXrender )
		virtual/x11 )"
#      utempter? ( sys-apps/utempter )

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_unpack() {

	unpack "${A}"
	cd "${S}"

	# 2005-12-21: Eliminate flicker for transparent terminals
	epatch "${FILESDIR}/noflicker-${PV}.patch"

	# 2005-12-22: Fix bug #1337635. Use ColorBD / ColorUL with xft
	epatch "${FILESDIR}/xft-colorbd-${PV}.patch"

	# 2005-12-22: Enable hilight color for selection
	sed -ie '99s/\/\* \(.*\) \*\//\1/' src/feature.h

}

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
