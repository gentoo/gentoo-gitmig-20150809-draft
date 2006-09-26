# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-canvas/gtk-canvas-0.1.1.ebuild,v 1.2 2006/09/26 07:57:39 dberkholz Exp $

inherit eutils autotools

DESCRIPTION="Backport of the GnomeCanvas widget to GTK+"
HOMEPAGE="http://www.atai.org/gtk-canvas/"
SRC_URI="http://www.atai.org/gtk-canvas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RDEPEND="gnome-base/gnome-libs"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/dont-build-libart_lgpl.patch
	cd ${S}
	eautoconf
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
