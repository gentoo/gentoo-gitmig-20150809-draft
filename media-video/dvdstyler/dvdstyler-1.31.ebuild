# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.31.ebuild,v 1.2 2005/03/30 10:55:49 luckyduck Exp $

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
	virtual/cdrtools"


DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gcc
	sys-devel/automake
	>=sys-apps/sed-4"

#	sys-devel/autoconf"
#PDEPEND= kde? and gnome

src_unpack() {
	unpack ${A}
}

src_compile() {
	# Propergate automake patch
	autoconf
	automake

	econf || die "Failed to configure"
	emake || die "Failed to make"
}


src_install() {
	emake DESTDIR=${D} install || die "failed to install"
	mv ${D}usr/share/docs ${D}usr/share/doc
	mv ${D}usr/share/doc/${PN} ${D}usr/share/doc/${PF}

	make_desktop_entry dvdstyler DVDStyler dvdstyler.png Application
}
