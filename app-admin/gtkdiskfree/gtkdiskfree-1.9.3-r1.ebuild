# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-1.9.3-r1.ebuild,v 1.13 2012/02/17 08:26:29 pacho Exp $

EAPI="4"
inherit eutils

DESCRIPTION="Graphical tool to show free disk space"
HOMEPAGE="http://gentoo.org/"
SRC_URI="http://gtkdiskfree.tuxfamily.org/src_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tempfile.patch #104565
	epatch "${FILESDIR}"/${PV}-makefile-DESTDIR.patch
	epatch "${FILESDIR}"/${P}-make-382.patch
	echo "Categories=GTK;System;Filesystem;" >> gtkdiskfree.desktop || die
}

src_configure() {
	econf \
		$(use_enable nls)
}

src_install() {
	default
	doicon gtkdiskfree.png
	domenu gtkdiskfree.desktop
}
