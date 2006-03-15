# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpde/xpde-0.5.1.ebuild,v 1.5 2006/03/15 08:39:48 spyderous Exp $

inherit eutils

DESCRIPTION="A Desktop Environment modelled after the O/S from Redmond, WA"
HOMEPAGE="http://www.xpde.com"
SRC_URI="http://www.xpde.com/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="|| ( x11-libs/libXpm virtual/x11 )
	media-libs/jpeg"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	einfo
	einfo "This is a binary-only package (sadly)"
	einfo "No files to compile."
	einfo
}

src_install() {
	cd ${S}/bin

	dodir /opt/xpde/bin/applets

	dodir /opt/xpde/share
	cp -pPR defaultdesktop ${D}/opt/xpde/share

	exeinto /opt/xpde/bin
	doexe *.so* startxpde xpde

	exeinto /opt/xpde/bin/applets
	doexe applets/desktop_properties

	exeinto /etc/X11/Sessions
	newexe startxpde ${P}
}
