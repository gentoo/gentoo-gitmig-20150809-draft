# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r3.ebuild,v 1.7 2004/11/01 17:49:24 corsair Exp $

inherit font

DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
LICENSE="public-domain"

KEYWORDS="x86 sparc ppc amd64 alpha ~ppc64"
IUSE=""
SLOT="0"

FONT_S=${WORKDIR}/sharefont
S=${FONT_S}

FONT_SUFFIX="pfb"

DOCS="*.shareware"
