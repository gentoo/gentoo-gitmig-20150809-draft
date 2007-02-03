# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.4.ebuild,v 1.3 2007/02/03 14:14:57 nelchael Exp $

inherit eutils autotools

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/xvidcap/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="gtk"

RDEPEND=">=media-video/ffmpeg-0.4.9_pre1
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	gnome-base/libgnome
	app-text/scrollkeeper
	gnome-base/libgnomeui"

DEPEND="${RDEPEND}"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-xtoxwd.c.patch"

}

src_compile() {

	econf `use_with gtk gtk2` || die "Configuration failed"
	emake || die "Compilation failed"

}

src_install() {

	einstall || die "Installation failed"

	# Fix for #58322
	rm -fr ${D}/usr/share/doc/${PN}_${PV}
	dodoc NEWS README AUTHORS ChangeLog

}
