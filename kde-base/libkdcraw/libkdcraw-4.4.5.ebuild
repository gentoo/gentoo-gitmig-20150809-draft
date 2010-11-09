# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.4.5.ebuild,v 1.6 2010/11/09 08:48:42 ssuominen Exp $

EAPI="3"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"

inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: a dcraw library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	virtual/jpeg
	media-libs/lcms:0
"
RDEPEND="${DEPEND}"
