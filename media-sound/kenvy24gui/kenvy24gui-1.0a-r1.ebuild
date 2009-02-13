# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kenvy24gui/kenvy24gui-1.0a-r1.ebuild,v 1.1 2009/02/13 20:37:18 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="VIA Envy24 based sound card control utility for KDE."
HOMEPAGE="http://kenvy24.wiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kenvy24/${P/0a/0.a}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=">=media-libs/alsa-lib-1.0.13"
RDEPEND="${DEPEND}"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}+autoconf-2.62.patch"
	"${FILESDIR}/${P}+gcc-4.3.patch"
	"${FILESDIR}/kenvy24gui-1.0a-desktop-file.diff" )

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}
