# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xawtv/xawtv-3.86-r2.ebuild,v 1.2 2005/01/25 15:25:35 cardoe Exp $

inherit virtualx eutils

IUSE="aalib alsa mmx motif nls opengl quicktime"

MY_PATCH="xaw-deinterlace-3.76-0.1.1.diff.bz2"
MY_FONT=tv-fonts-1.0
DESCRIPTION="TV application for the bttv driver"
HOMEPAGE="http://bytesex.org/xawtv/"
SRC_URI="http://bytesex.org/xawtv/${PN}_${PV}.tar.gz
	http://bytesex.org/xawtv/${MY_FONT}.tar.bz2
	mirror://gentoo/${MY_PATCH}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
	media-libs/libpng
	media-libs/zvbi
	virtual/x11
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	motif? ( x11-libs/openmotif
		app-text/recode )
	opengl? ( virtual/opengl )
	quicktime? ( virtual/quicktime )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/alevtd-style-mozilla.diff
}

src_compile() {
	use mmx || \
		sed -i "s:#define MMX::" libng/plugins/linear_blend.c

	econf \
		`use_enable alsa` \
		`use_enable opengl gl` \
		`use_enable quicktime` \
		`use_enable motif` \
		`use_enable aalib aa` \
		--with-x \
		--enable-xfree-ext \
		--enable-xvideo \
		--enable-zvbi || die "xawtv failed"

	make || die

	cd ${WORKDIR}/${MY_FONT}
	DISPLAY="" Xmake || die "tvfonts failed"
}

src_install() {
	cd ${S}
	einstall \
		libdir=${D}/usr/lib/xawtv \
		resdir=${D}/etc/X11 || die

	dodoc COPYING Changes README* TODO

	if [ -d /home/httpd ]
	then
		exeinto /home/httpd/cgi-bin
		doexe scripts/webcam.cgi
		dodoc ${FILESDIR}/webcamrc
	fi

	if ! use nls
	then
		rm -f ${D}/usr/share/man/fr
		rm -f ${D}/usr/share/man/es
	fi

	# The makefile seems to be fubar'd for some data
	dodir /usr/share/${PN}
	mv ${D}/usr/share/*.list ${D}/usr/share/${PN}
	mv ${D}/usr/share/Index* ${D}/usr/share/${PN}

	cd ${WORKDIR}/${MY_FONT}
	insinto /usr/X11R6/lib/X11/fonts/xawtv
	doins *.gz fonts.alias
}

pkg_postinst() {

	ebegin "installing teletype fonts into /usr/X11R6/lib/X11/fonts/xawtv"
	cd /usr/X11R6/lib/X11/fonts/xawtv
	mkfontdir
	eend
}
