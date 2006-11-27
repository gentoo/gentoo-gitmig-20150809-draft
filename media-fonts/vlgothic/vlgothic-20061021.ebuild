# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vlgothic/vlgothic-20061021.ebuild,v 1.3 2006/11/27 00:01:25 flameeyes Exp $

inherit font

DESCRIPTION="Japanese TrueType font from Vine Linux"
HOMEPAGE="http://dicey.org/vlgothic/"
SRC_URI="http://vinelinux.org/~daisuke/tmp/VLGothic-${PV}.tar.bz2
	http://dicey.org/vlgothic/VLGothic-${PV}.tar.bz2"

LICENSE="mplus-fonts BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="LICENSE* README*"
