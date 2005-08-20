# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.6.3.ebuild,v 1.1 2005/08/20 08:06:06 dragonheart Exp $

inherit eutils flag-o-matic kde-functions

DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${P}.tar.gz"
IUSE="kde"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="virtual/x11
	dev-libs/expat
	sys-apps/groff
	dev-lang/perl
	>=sys-apps/sed-4
	media-libs/libmpeg2
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	virtual/libc
	sys-libs/zlib"

RDEPEND="virtual/x11
	dev-libs/expat
	net-misc/curl
	media-gfx/xloadimage
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	virtual/libc
	sys-libs/zlib"

# Also detects and ties in sys-libs/slang, media-libs/aalib media-libs/svgalib and nas
# if they exist on the user machine although these aren't deps.

src_unpack1() {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/share:/usr/share/${PN}:" \
		electricsheep.c \
		|| die "sed electricsheep.c failed"
	sed -i '/OPT_CFLAGS=/s:=".*":="$CFLAGS":' \
		mpeg2dec/configure \
		|| die "sed mpeg2dec failed"
#	epatch ${FILESDIR}/nice.patch
	filter-flags -fPIC
}

src_install() {


	# prevent writing for xscreensaver
	sed -i "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile || die "sed Makefile failed"

	# install the xscreensaver config file
	insinto /usr/share/control-center/screensavers
	doins electricsheep.xml

	make install DESTDIR=${D} || die "make install failed"

	dodir /usr/share/electricsheep
	if [ ! -f ${ROOT}/usr/share/electricsheep/electricsheep-uniqueid ]
	then
		${D}/usr/bin/uniqueid > ${D}/usr/share/electricsheep/electricsheep-uniqueid
	fi

	if use kde;
	then
		set-kdedir
		insinto /usr/share/applications
		doins ${FILESDIR}/${PN}.desktop
		insinto ${KDEDIR}//share/applnk/System/ScreenSavers
		doins ${FILESDIR}/${PN}.desktop
	fi

	# remove header files that are installed over libmpeg2
	rm -rf ${D}/usr/include
}
