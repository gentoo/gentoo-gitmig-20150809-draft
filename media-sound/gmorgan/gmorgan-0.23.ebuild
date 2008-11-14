# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmorgan/gmorgan-0.23.ebuild,v 1.7 2008/11/14 10:23:38 aballier Exp $

EAPI=1

WANT_AUTOMAKE=1.9
WANT_AUTOCONF=2.5

inherit eutils autotools

IUSE="nls"

DESCRIPTION="gmorgan is an opensource software rhythm station."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"

RDEPEND=">=x11-libs/fltk-1.1.2:1.1
	>=media-libs/alsa-lib-0.9.0"

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.5-r1 )"

src_unpack() {
	unpack ${A}
	cd "${S}/po"
	sed -i "/mkinstalldirs =/s%.*%mkinstalldirs = ../mkinstalldirs%" Makefile.in.in
	cd "${S}"
	epatch "${FILESDIR}/${PN}-amd64.patch"
	eautoreconf
}

src_install() {
	make prefix="${D}/usr" localedir="${D}/usr/share/locale" install || die
	dodoc AUTHORS NEWS README
}
