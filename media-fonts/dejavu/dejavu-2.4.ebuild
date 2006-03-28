# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/dejavu/dejavu-2.4.ebuild,v 1.1 2006/03/28 22:04:42 flameeyes Exp $

inherit font versionator

MY_P="${PN/dejavu/dejavu-ttf}-$(replace_version_separator 2 -)"

DESCRIPTION="DejaVu fonts, bitstream vera with ISO-8859-2 characters"
HOMEPAGE="http://dejavu.sourceforge.net/"
LICENSE="BitstreamVera"
SRC_URI="mirror://sourceforge/dejavu/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DOCS="AUTHORS BUGS LICENSE NEWS README status.txt"
FONT_SUFFIX="ttf"
S="${WORKDIR}/${PN}-ttf-$(get_version_component_range 1-2)"
FONT_S="${S}"
