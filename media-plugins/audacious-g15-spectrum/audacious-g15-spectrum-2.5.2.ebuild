# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-g15-spectrum/audacious-g15-spectrum-2.5.2.ebuild,v 1.3 2008/01/18 11:54:25 chainsaw Exp $

inherit eutils versionator

MY_PN="g15daemon-audacious"
DESCRIPTION="Audacious Spectrum plugin to G15daemon"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 x86"
IUSE=""

DEPEND=">=app-misc/g15daemon-1.9.0
	dev-libs/libg15
	>=dev-libs/libg15render-1.2
	>=media-sound/audacious-1.3
	>=x11-libs/gtk+-2.6.0
	dev-libs/glib
	x11-libs/pango"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if has_version '>=media-sound/audacious-1.4'; then
		epatch "${FILESDIR}"/${P}-audacious-1.4.patch
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
}
