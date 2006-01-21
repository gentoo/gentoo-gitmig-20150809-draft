# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-2.0.10-r2.ebuild,v 1.1 2006/01/21 22:28:09 compnerd Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://live.gnome.org/GnomePilot"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0
	>=app-pda/gnome-pilot-${PVR}
	>=dev-libs/libxml2-2.5"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	${RDEPEND}"

SCROLLKEEPER_UPDATE="0"

pkg_setup() {
	G2CONF="${G2CONF} --enable-pilotlinktest"
}

src_unpack() {
	unpack ${A}

	# patch to fix memo file syncing
	# http://bugzilla.gnome.org/show_bug.cgi?id=114361
	epatch ${FILESDIR}/${P}-memofile.patch

	# Patch to fix invalid linguas (Bug #114650)
	# patch from Philippe Troin <phil@fifi.org>
	cd ${S} ; epatch ${FILESDIR}/${PN}-2.0.10-invalid-linguas.patch
}
