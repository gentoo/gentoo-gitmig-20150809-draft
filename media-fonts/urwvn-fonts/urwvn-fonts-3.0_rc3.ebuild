# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urwvn-fonts/urwvn-fonts-3.0_rc3.ebuild,v 1.3 2006/03/20 00:11:00 halcy0n Exp $

inherit font

MY_P=${P/_/-}
MY_P=${MY_P/-fonts/}
DESCRIPTION="free good quality fonts gpl'd by Han The Thanh, based on URW++ fonts"
HOMEPAGE="http://vntex.sourceforge.net/urwvn/"
SRC_URI="http://vntex.sourceforge.net/urwvn/latest/${MY_P}-ttf.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}
FONT_SUFFIX="ttf"
FONT_S=${S}

DEPEND="app-arch/unzip"
