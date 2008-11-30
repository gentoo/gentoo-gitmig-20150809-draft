# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vlgothic/vlgothic-20081029.ebuild,v 1.6 2008/11/30 16:06:29 maekke Exp $

inherit font

DESCRIPTION="Japanese TrueType font from Vine Linux"
HOMEPAGE="http://dicey.org/vlgothic/"
SRC_URI="http://vinelinux.org/~daisuke/vlgothic/VLGothic-${PV}.tar.bz2"

# M+ FONTS -> mplus-fonts
# sazanami -> BSD-2
LICENSE="vlgothic mplus-fonts BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="Changelog README*"
