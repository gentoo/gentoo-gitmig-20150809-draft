# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gnome-chord/gnome-chord-0.7.0.ebuild,v 1.5 2004/03/13 23:00:56 mr_bones_ Exp $

inherit gnome2

S="${WORKDIR}/${PN}2-${PV}"

DESCRIPTION="Chord and scale editor for gnome"
HOMEPAGE="http://gnome-chord.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnome-chord/${PN}2-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-1.2"

RDEPEND="${DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

