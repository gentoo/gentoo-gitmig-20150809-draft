# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-0.9.ebuild,v 1.2 2004/03/24 17:19:52 mholzer Exp $

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}-1.tar.bz2"
RESTRICT="nomirror"
S="${WORKDIR}/BloGTK-${PV}-1"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=""

RDEPEND=">=dev-python/pygtk-2.0.0
	>=gnome-base/gconf-2.2.0
	dev-python/gnome-python"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_install() {
	sed -e 's/PREFIX ?=/#&/g' Makefile | sed -e 's/#PREFIX = /PREFIX = ${D}/g' \
		> Makefile.tmp && mv Makefile.tmp Makefile
	make PREFIX="${D}/usr" || die "Unable to compile blogtk"
}
