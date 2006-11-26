# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unfonts-extra/unfonts-extra-1.0.1.ebuild,v 1.9 2006/11/26 23:07:58 flameeyes Exp $

inherit font

MY_PN="un-fonts"
S=${WORKDIR}/${MY_PN}

DESCRIPTION="Korean UnFonts with various decorative font families"
HOMEPAGE="http://kldp.net/projects/unfonts/"
SRC_URI="http://kldp.net/download.php/1435/${MY_PN}-extra-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S=${S}

# Only installs fonts
RESTRICT="strip binchecks"
