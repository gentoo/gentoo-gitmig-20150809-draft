# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urwvn-fonts/urwvn-fonts-3.04.ebuild,v 1.8 2010/05/08 06:18:29 pva Exp $

inherit font

MY_P=${P/_/-}
MY_P=${MY_P/-fonts/}
DESCRIPTION="fonts gpl'd by Han The Thanh, based on URW++ fonts with Vietnamese glyphs added"
HOMEPAGE="http://vntex.sf.net"
SRC_URI="http://vntex.org/urwvn/download/${MY_P}-ttf.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}-ttf"
FONT_SUFFIX="ttf"
FONT_S=${S}

DEPEND="app-arch/unzip"
