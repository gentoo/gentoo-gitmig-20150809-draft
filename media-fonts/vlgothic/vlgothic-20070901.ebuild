# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vlgothic/vlgothic-20070901.ebuild,v 1.1 2007/09/09 05:52:10 matsuu Exp $

inherit font

DESCRIPTION="Japanese TrueType font from Vine Linux"
HOMEPAGE="http://dicey.org/vlgothic/"
SRC_URI="http://vinelinux.org/~daisuke/vlgothic/VLGothic-${PV}.tar.bz2"

LICENSE="vlgothic mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="Changelog README*"
