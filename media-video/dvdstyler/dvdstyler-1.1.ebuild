# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.1.ebuild,v 1.1 2004/11/21 09:43:40 dragonheart Exp $

inherit eutils

MY_P=DVDStyler-${PV}

DESCRIPTION="DVD filesystem Builder"
HOMEPAGE="http://dvdstyler.sourceforge.net"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome"
S=${WORKDIR}/${MY_P}

RDEPEND="virtual/x11
	>=x11-libs/wxGTK-2.4.2
	>=media-video/mjpegtools-1.6.2
	>=media-video/dvdauthor-0.6.10
	gnome? ( >=gnome-base/libgnomeui-2.0 )
	media-video/mpgtx
	x11-libs/gtk+
	dev-libs/expat
	virtual/libc
	media-libs/tiff
	media-libs/libpng
	media-libs/jpeg
	media-libs/netpbm
	dev-libs/glib
	sys-libs/zlib
	app-cdr/dvd+rw-tools
	app-cdr/cdrtools"


DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gcc
	sys-devel/automake
	>=sys-apps/sed-4"

#	sys-devel/autoconf"
#PDEPEND= kde? and gnome

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gcc34.patch
	epatch ${FILESDIR}/${PV}-AutoMakefile.patch
	epatch ${FILESDIR}/${PV}-code.patch
	cd ${S}
}

src_compile() {
	# Propergate automake patch
	autoconf
	automake

	econf \
		|| die "Failed to configure"

	# sed -i -e "s:^prefix=.*${PN}\$::g" configure*
	# sed -i -e "s:^dvdstyler_LDADD =:dvdstyler_LDADD =-lexpat:" src/Makefile.in

	# emake -C wxXML CPPFLAGS=-DSYSEXPAT=1 || die "Failed to make wxXML helpers"
	emake || die "Failed to make"
}


src_install() {
	emake DESTDIR=${D} install || die "failed to install"
	mv ${D}usr/share/docs/DVDStyler/silence.mp2 ${D}usr/share/DVDStyler
	dodir /usr/share/doc/${PF}
	mv ${D}usr/share/docs/DVDStyler ${D}usr/share/doc/${PF}
	rmdir ${D}usr/share/docs
}
