# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-2.0.10-r1.ebuild,v 1.10 2004/10/19 18:39:00 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://www.gnome.org/projects/gnome-pilot/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0
	>=app-pda/gnome-pilot-${PVR}
	>=dev-libs/libxml2-2.5"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	${RDEPEND}"

G2CONF="${G2CONF} --enable-pilotlinktest"
SCROLLKEEPER_UPDATE="0"

src_unpack() {
	unpack ${A}
	# patch to fix memo file syncing
	# http://bugzilla.gnome.org/show_bug.cgi?id=114361
	epatch ${FILESDIR}/${P}-memofile.patch
}
