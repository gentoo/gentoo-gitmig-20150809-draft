# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r3.ebuild,v 1.3 2004/06/24 22:31:00 agriffis Exp $

inherit font

DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
LICENSE="public-domain"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""
SLOT="0"

S=${WORKDIR}/sharefont

FONT_SUFFIX="pfb"

DOCS="*.shareware"
