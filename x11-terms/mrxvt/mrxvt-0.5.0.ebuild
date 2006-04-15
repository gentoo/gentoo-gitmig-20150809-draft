# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mrxvt/mrxvt-0.5.0.ebuild,v 1.1 2006/04/15 00:13:01 nelchael Exp $

inherit eutils

IUSE="debug png jpeg session truetype menubar"

DESCRIPTION="Multi-tabbed rxvt clone with XFT, transparent background and CJK support"
HOMEPAGE="http://materm.sourceforge.net/"
SRC_URI="mirror://sourceforge/materm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc-macos ~amd64 ~ppc ~alpha"

RDEPEND="png? media-libs/libpng
	jpeg? media-libs/jpeg
	truetype? ( virtual/xft
		media-libs/fontconfig
		media-libs/freetype )
	|| ( (
			x11-libs/libX11
			x11-libs/libXt
			x11-libs/libXpm
			x11-libs/libXrender )
		virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

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

	# 2006-03-13 gi1242: mrxvt works best with TERM=rxvt AND correctly set
	# termcap / terminfo entries. If the rxvt termcap / terminfo entries are
	# messed up then then it's better to set TERM=xterm.
	#
	# Provide support for this by setting the or RXVT_TERM environment variables
	# before emerging, as done in the rxvt ebuild.

	if [[ -n ${RXVT_TERM} ]]; then
		myconf="${myconf} --with-term=${RXVT_TERM}"
	fi

	econf \
		--enable-everything \
		$(use_enable debug) \
		$(use_enable png) \
		$(use_enable jpeg) \
		$(use_enable session sessionmgr) \
		$(use_enable truetype xft) \
		$(use_enable menubar) \
		${myconf} || die

	emake || die

}

src_install() {

	make DESTDIR=${D} docdir=/usr/share/doc/${PF} install || die
	dodoc AUTHORS CREDITS ChangeLog FAQ NEWS README* TODO

}

pkg_postinst() {

	if [[ -z $RXVT_TERM ]]; then
		einfo
		einfo "If you experience problems with curses programs, then this is"
		einfo "most likely because of incorrectly set termcap / terminfo"
		einfo "entries. If you are unsure how to fix them, then you can try"
		einfo "setting TERM=xterm."
		einfo
		einfo "To emerge mrxvt with TERM=xterm by default, set the RXVT_TERM"
		einfo "environment variable to 'xterm', or your desired default"
		einfo "terminal name. Alternately you can put 'Mrxvt.termName: xterm'"
		einfo "in your ~/.mrxvtrc, or /etc/mrxvt/mrxvtrc."
		einfo
	fi

}
