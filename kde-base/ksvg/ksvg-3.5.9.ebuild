# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.5.9.ebuild,v 1.5 2008/05/13 02:30:14 jer Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/freetype-2.3
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
RDEPEND="${DEPEND}"
