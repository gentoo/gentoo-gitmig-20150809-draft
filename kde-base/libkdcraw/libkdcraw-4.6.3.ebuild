# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.6.3.ebuild,v 1.1 2011/05/07 10:47:59 scarabeus Exp $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	KMMODULE="libs/${PN}"
	inherit kde4-meta
fi

DESCRIPTION="KDE digital camera raw image library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
