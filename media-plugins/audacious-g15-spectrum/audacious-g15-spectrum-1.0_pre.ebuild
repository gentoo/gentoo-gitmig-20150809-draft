# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-g15-spectrum/audacious-g15-spectrum-1.0_pre.ebuild,v 1.3 2007/05/01 10:20:50 corsair Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 2 '' )
MY_PN="g15daemon_audacious_spectrum"

DESCRIPTION="Audacious Spectrum plugin to G15daemon"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=app-misc/g15daemon-1.9.0
	dev-libs/libg15
	>=dev-libs/libg15render-1.2
	>=media-sound/audacious-1.3
	>=x11-libs/gtk+-2.6.0
	dev-libs/glib
	x11-libs/pango"

RDEPEND="${DEPEND}"

S="$WORKDIR/${MY_PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-audacious-1.3.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
