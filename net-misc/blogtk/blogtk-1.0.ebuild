# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-1.0.ebuild,v 1.4 2005/08/07 12:58:47 hansmi Exp $

inherit eutils

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.bz2"
RESTRICT="nomirror"
S="${WORKDIR}/BloGTK-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.0.0
	>=gnome-base/gconf-2.2.0
	>=dev-python/gnome-python-2"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile() {
	return
}

src_install() {
	make DESTDIR=${D} install || die "Unable to compile blogtk"
}
