# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmblob/wmblob-1.0.1.ebuild,v 1.9 2006/10/18 08:10:56 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmblob shows some blobs moving around"
SRC_URI="http://dockapps.org/download.php/id/440/${P}.tar.bz2"
HOMEPAGE="http://dockapps.org/file.php/id/155"

DEPEND=">=x11-libs/pango-1.4.0
	>=x11-libs/gtk+-2.4.1
	>=dev-util/pkgconfig-0.15.0
	x11-libs/libXpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# We patch the ./configure script to make it honour Gentoo CFLAGS and the
	# X11 location
	epatch ${FILESDIR}/${PN}-configure-fixes.patch
}

src_compile() {
	econf --with-x --prefix=/usr GENTOO_CFLAGS="${CFLAGS}" \
		|| die "configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc README AUTHORS ChangeLog doc/how_it_works

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
