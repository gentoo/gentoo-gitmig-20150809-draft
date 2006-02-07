# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvtime/tvtime-0.9.15.ebuild,v 1.5 2006/02/07 20:44:37 blubb Exp $

inherit eutils

DESCRIPTION="High quality television application for use with video capture cards."
HOMEPAGE="http://tvtime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="virtual/x11
	>=media-libs/freetype-2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=dev-libs/libxml2-2.5.11"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	# use 'tvtime' for the application icon see bug #66293
	sed -i -e "s/tvtime.png/tvtime/" ${S}/docs/net-tvtime.desktop
	# patch to adapt to PIC or __PIC__ for pic support
	# see bug #74227
	cd ${S}
	epatch ${FILESDIR}/${PN}-pic.patch

}

src_compile() {

	econf `use_enable nls` || die "econf failed"

	emake || die "compile problem"

}

src_install () {

	make DESTDIR=${D} install || die "make install failed"

	dohtml docs/html/*
	dodoc ChangeLog AUTHORS NEWS README COPYING data/COPYING.*

}

pkg_postinst() {
	einfo "A default setup for ${PN} has been saved as"
	einfo "/etc/tvtime/tvtime.xml. You may need to modify it"
	einfo "for your needs."
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	echo
}

