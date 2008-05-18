# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/farsi-fonts/farsi-fonts-0.4.ebuild,v 1.11 2008/05/18 23:48:34 dirtyepic Exp $

inherit font

S=${WORKDIR}/${P/-/}

DESCRIPTION="Farsi (Persian) Unicode fonts"
HOMEPAGE="http://www.farsiweb.ir/wiki/Products/PersianFonts"
SRC_URI="http://www.farsiweb.ir/font/farsifonts-${PV}.zip"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
