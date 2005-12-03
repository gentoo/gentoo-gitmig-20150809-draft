# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urwvn-fonts/urwvn-fonts-3.0_rc3.ebuild,v 1.1 2005/12/03 09:05:43 pclouds Exp $

inherit font

MY_P=${P/_/-}
MY_P=${MY_P/-fonts/}
DESCRIPTION="free good quality fonts gpl'd by Han The Thanh, based on URW++ fonts"
HOMEPAGE="http://vntex.sourceforge.net/urwvn/"
SRC_URI="http://vntex.sourceforge.net/urwvn/latest/${MY_P}-ttf.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

S=${WORKDIR}
FONT_SUFFIX="ttf"
FONT_S=${S}
