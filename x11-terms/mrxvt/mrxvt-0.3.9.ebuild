# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mrxvt/mrxvt-0.3.9.ebuild,v 1.2 2004/12/08 05:37:09 usata Exp $

IUSE="debug truetype xgetdefault"
#IUSE="${IUSE} utempter"

DESCRIPTION="Multi-tabbed rxvt clone with XFT, transparent background and CJK support"
HOMEPAGE="http://materm.sourceforge.net/"
SRC_URI="mirror://sourceforge/materm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc-macos ~amd64 ppc alpha"

RDEPEND="virtual/libc
	virtual/x11
	dev-libs/expat
	media-libs/libpng
	media-libs/jpeg
	truetype? ( virtual/xft
		media-libs/fontconfig
		media-libs/freetype )"
#	utempter? ( sys-apps/utempter )
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

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

	./bootstrap.sh

	econf \
		--enable-everything \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-fading \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-ttygid \
		--enable-256-color \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling \
		--enable-xft \
		$(use_enable xgetdefault) \
		$(use_enable truetype xft) \
		$(use_enable debug) \
		--disable-text-blink \
		--disable-menubar \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} docdir=/usr/share/doc/${PF} install || die

	dodoc AUTHORS CREDITS ChangeLog FAQ NEWS README* TODO
}
