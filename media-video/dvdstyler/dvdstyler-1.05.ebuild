# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.05.ebuild,v 1.1 2004/07/30 04:59:28 dragonheart Exp $

inherit eutils

MY_P=DVDStyler-${PV}

DESCRIPTION="DVD filesystem Builder"
HOMEPAGE="http://dvdstyler.sourceforge.net"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}

RDEPEND="virtual/x11
	>=x11-libs/wxGTK-2.4.2
	>=media-video/mjpegtools-1.6.2
	>=media-video/dvdauthor-0.6.10
	media-video/mpgtx
	>=gnome-base/libgnomeui-2.0
	x11-libs/gtk+
	virtual/libc
	media-libs/tiff
	media-libs/libpng
	media-libs/jpeg
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
	epatch ${FILESDIR}/${PV}-AutoMakefile.patch
	epatch ${FILESDIR}/${PV}-code.patch
	sed -i -e "s:-O3::g" ${S}/configure.in ${S}/configure
}

src_compile() {
	# Propergate automake patch
	# autoconf
	automake

	econf || die "Failed to configure"

	sed -i -e "s:^prefix=.*${PN}\$::g" configure*

	emake || dir "Failed to make"
}


src_install() {

	emake DESTDIR=${D} install

	mv ${D}/usr/share/docs/DVDStyler ${D}/usr/share/docs/${PF}
}
