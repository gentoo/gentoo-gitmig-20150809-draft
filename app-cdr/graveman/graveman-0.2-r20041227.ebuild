# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.2-r20041227.ebuild,v 1.1 2005/01/08 07:35:25 pylon Exp $

IUSE="oggvorbis sox"

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://scresto.site.voila.fr/gravemanuk.html"
SRC_URI="http://scresto.site.voila.fr/data/${PN}/${PN}_${PVR/-r/_}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
S="${WORKDIR}/${P}"

DEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.4.0
	>=media-libs/libid3tag-0.15
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"
RDEPEND="${DEPEND}
	sox? ( >=media-sound/sox-12.17.0 )
	>=app-cdr/cdrtools-2.0"

src_install() {
	cd ${S}
	einstall || die
}

