# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/skippy/skippy-0.5.0.ebuild,v 1.13 2009/01/09 14:24:15 remi Exp $

inherit eutils

IUSE=""

DESCRIPTION="A full-screen task-switcher providing Apple Expose-like functionality with various WMs"
HOMEPAGE="http://thegraveyard.org/skippy.php"
SRC_URI="http://thegraveyard.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXft"

DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto
	dev-util/pkgconfig
	>=media-libs/imlib2-1.1.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-pointer-size.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die

	insinto /usr/share/${P}
	doins skippyrc-default

	dodoc CHANGELOG
}

pkg_postinst() {
	einfo
	einfo "You should copy /usr/share/${P}/skippyrc-default to ~/.skippyrc"
	einfo "and edit the keysym used to invoke skippy"
	einfo "(Find out the keysym name using 'xev')"
	einfo
	echo
}
