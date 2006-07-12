# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unfonts/unfonts-1.0.ebuild,v 1.7 2006/07/12 12:21:51 agriffis Exp $

inherit font

MY_PN="un-fonts"
S=${WORKDIR}/${MY_PN}

DESCRIPTION="Korean UnFonts with basic font families"
HOMEPAGE="http://kldp.net/projects/unfonts/"

SRC_URI="http://kldp.net/download.php/1425/${MY_PN}-core-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S=${S}

