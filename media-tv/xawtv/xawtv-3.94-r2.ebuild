# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xawtv/xawtv-3.94-r2.ebuild,v 1.5 2005/10/09 12:29:17 zzam Exp $

inherit virtualx eutils font

IUSE="aalib alsa dv lirc mmx motif nls opengl quicktime X xv zvbi"

MY_PATCH="xaw-deinterlace-3.76-0.1.1.diff.bz2"
MY_FONT=tv-fonts-1.0
DESCRIPTION="TV application for the bttv driver"
HOMEPAGE="http://bytesex.org/xawtv/"
SRC_URI="http://dl.bytesex.org/releases/xawtv/${P}.tar.gz
	X? ( http://dl.bytesex.org/releases/tv-fonts/${MY_FONT}.tar.bz2 )
	mirror://gentoo/${MY_PATCH}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"

DEPEND=">=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
	media-libs/libpng
	X? ( virtual/x11 )
	motif? ( virtual/x11
		x11-libs/openmotif
		app-text/recode )
	xv? ( virtual/x11 )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	dv? ( media-libs/libdv )
	lirc? ( app-misc/lirc )
	opengl? ( virtual/opengl )
	quicktime? ( virtual/quicktime )
	zvbi? ( media-libs/zvbi )
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

pkg_setup() {
	if use X; then
		font_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-allow-xlibs-in-normal-search-path.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-no-x11.patch
	cd ${S}
	autoreconf || "reconf failed"
}

src_compile() {
	econf \
		$(use_with X x) \
		$(use_enable X xfree-ext) \
		$(use_enable xv xvideo) \
		$(use_enable dv)  \
		$(use_enable mmx) \
		$(use_enable motif) \
		$(use_enable quicktime) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable opengl gl) \
		$(use_enable zvbi) \
		$(use_enable aalib aa) \
		|| die " xawtv configure failed"

	emake || die "Make failed"

	if use X; then
		cd ${WORKDIR}/${MY_FONT}
		DISPLAY="" Xmake || die "tvfonts failed"
	fi
}

src_install() {
	cd ${S}
	make install DESTDIR=${D} resdir=${D}/etc/X11 || die "make install failed"

	dodoc COPYING Changes README* TODO ${FILESDIR}/webcamrc
	insinto cgi-bin
	dodoc scripts/webcam.cgi

	use X || use xv || \
		rm -f ${D}/usr/share/man/man1/{pia,propwatch}.1 \
			${D}/usr/share/{man,man/fr,man/es}/man1/xawtv.1 \
			${D}/usr/share/{man,man/es}/man1/{rootv,v4lctl,xawtv-remote}.1

	use motif || \
		rm -f ${D}/usr/share/man/man1/{motv,mtt}.1

	use zvbi || \
		rm -f ${D}/usr/share/man/man1/{alevtd,mtt}.1 \
			${D}/usr/share/{man,man/es}/man1/scantv.1

	use nls || \
		rm -f ${D}/usr/share/man/fr \
			${D}/usr/share/man/es

	# The makefile seems to be fubar'd for some data
	dodir /usr/share/${PN}
	mv ${D}/usr/share/*.list ${D}/usr/share/${PN}
	mv ${D}/usr/share/Index* ${D}/usr/share/${PN}

	if use X; then
		cd ${WORKDIR}/${MY_FONT}
		insinto /usr/share/fonts/xawtv
		doins *.gz fonts.alias

		font_xfont_config
		font_xft_config
	fi
}

pkg_postinst() {
	if use X; then
		ebegin "installing teletype fonts into /usr/share/fonts/xawtv"
		cd /usr/share/fonts/xawtv
		mkfontdir
		eend
	fi
}
