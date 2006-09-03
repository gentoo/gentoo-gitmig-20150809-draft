# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r3.ebuild,v 1.10 2006/09/03 06:44:22 vapier Exp $

inherit font

DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
LICENSE="public-domain"

KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""
SLOT="0"

FONT_S=${WORKDIR}/sharefont
S=${FONT_S}

FONT_SUFFIX="pfb"

DOCS="*.shareware"
