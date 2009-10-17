# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkexiv2/libkexiv2-0.1.8-r1.ebuild,v 1.7 2009/10/17 11:53:21 ssuominen Exp $

EAPI=1

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE Image Plugin Interface: An exiv2 library wrapper."
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ia64 ppc sparc"
IUSE=""

RDEPEND=">=media-gfx/exiv2-0.18
	!${CATEGORY}/${PN}:3.5
	!kde-base/${PN}"
DEPEND="${RDEPEND}"

need-kde 3.5
