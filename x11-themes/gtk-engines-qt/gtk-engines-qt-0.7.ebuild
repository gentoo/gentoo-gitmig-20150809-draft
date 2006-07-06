# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.7.ebuild,v 1.1 2006/07/06 22:54:54 genstef Exp $

inherit kde eutils

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://www.freedesktop.org/Software/gtk-qt"
SRC_URI="http://www.freedesktop.org/~davidsansome/${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.2"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gtk-engines-qt-0.7-implicit.patch
}

src_install() {
	kde_src_install
	# remove duplicate .desktop
	rm ${D}/usr/share/applnk/Settings/LookNFeel/kcmgtk.desktop
}
