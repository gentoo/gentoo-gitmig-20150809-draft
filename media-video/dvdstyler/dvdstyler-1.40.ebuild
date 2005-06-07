# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.40.ebuild,v 1.2 2005/06/07 19:20:15 luckyduck Exp $

inherit eutils

MY_P=DVDStyler-${PV/0/}

DESCRIPTION="DVD filesystem Builder"
HOMEPAGE="http://dvdstyler.sourceforge.net"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome"

RDEPEND="app-cdr/dvd+rw-tools
	dev-libs/expat
	dev-libs/glib
	media-libs/tiff
	media-libs/libpng
	media-libs/jpeg
	media-libs/netpbm
	>=media-video/dvdauthor-0.6.10
	media-video/mpgtx
	>=media-video/mjpegtools-1.6.2
	sys-libs/zlib
	x11-libs/gtk+
	=x11-libs/wxGTK-2.4*
	virtual/cdrtools
	virtual/libc
	virtual/x11
	gnome? ( >=gnome-base/libgnomeui-2.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	# Propagate automake patch
	autoconf
	automake

	econf || die "Failed to configure"
	emake || die "Failed to make"
}


src_install() {
	make DESTDIR=${D} install || die "failed to install"
	mv ${D}usr/share/docs ${D}usr/share/doc
	mv ${D}usr/share/doc/${PN} ${D}usr/share/doc/${PF}

	make_desktop_entry dvdstyler DVDStyler dvdstyler.png Application
}
