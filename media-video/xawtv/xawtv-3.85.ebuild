# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/xawtv/xawtv-3.85.ebuild,v 1.3 2003/03/13 23:26:04 seemant Exp $

inherit eutils

IUSE="aalib motif alsa opengl nls quicktime"

MY_PATCH="xaw-deinterlace-3.76-0.1.1.diff.bz2"
S=${WORKDIR}/${P}
MY_FONT=tv-fonts-1.0
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://bytesex.org/xawtv/${PN}_${PV}.tar.gz
	http://bytesex.org/xawtv/${MY_FONT}.tar.bz2
	http://cvs.gentoo.org/~seemant/${MY_PATCH}
	mirror://gentoo/${MY_PATCH}"
HOMEPAGE="http://bytesex.org/xawtv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
	media-libs/libpng
	media-libs/xpm
	media-libs/zvbi
	virtual/x11
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	motif? ( virtual/motif
		app-text/recode )
	opengl? ( virtual/opengl )
	quicktime? ( media-libs/libquicktime )"

src_unpack() {
	unpack ${PN}_${PV}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${MY_PATCH}

	use mmx || \
		ssed -i "s:#define MMX::" libng/plugins/linear_blend.c

	unpack ${MY_FONT}.tar.bz2
	cd ${S}/${MY_FONT}
	epatch ${FILESDIR}/${MY_FONT}-gentoo.diff
}

src_compile() {
	local myconf
	use motif \
		&& myconf="--enable-motif" \
		|| myconf="--disable-motif"

	use aalib \
		&& myconf="${myconf} --enable-aa" \
		|| myconf="${myconf} --disable-aa"

	use quicktime \
		&& myconf="${myconf} --enable-quicktime" \
		|| myconf="${myconf} --disable-quicktime"

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"


	use opengl \
		&& myconf="${myconf} --enable-gl" \
		|| myconf="${myconf} --disable-gl"

	econf \
		--with-x \
		--enable-xfree-ext \
		--enable-xvideo \
		--enable-zvbi \
		${myconf} || die

	make || die

	cd ${MY_FONT}
	make || die
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

	if [ -z "`use nls`" ]
	then
		rm -f ${D}/usr/share/man/fr
		rm -f ${D}/usr/share/man/es
	fi

	# The makefile seems to be fubar'd for some data
	dodir /usr/share/${PN}
	mv ${D}/usr/share/*.list ${D}/usr/share/${PN}
	mv ${D}/usr/share/Index* ${D}/usr/share/${PN}

	cd ${MY_FONT}
	insinto /usr/X11R6/lib/X11/fonts/xawtv
	doins *.gz fonts.alias
}

pkg_postinst() {

	ebegin "installing teletype fonts into /usr/X11R6/lib/X11/fonts/xawtv"
	cd /usr/X11R6/lib/X11/fonts/xawtv
	mkfontdir
	eend
}
