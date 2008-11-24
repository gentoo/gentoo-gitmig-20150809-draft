# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vlgothic/vlgothic-20081124.ebuild,v 1.1 2008/11/24 00:11:38 matsuu Exp $

inherit font

DESCRIPTION="Japanese TrueType font from Vine Linux"
HOMEPAGE="http://dicey.org/vlgothic/"
SRC_URI="http://vinelinux.org/~daisuke/vlgothic/VLGothic-${PV}.tar.bz2"

LICENSE="vlgothic mplus-fonts"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="Changelog README*"
