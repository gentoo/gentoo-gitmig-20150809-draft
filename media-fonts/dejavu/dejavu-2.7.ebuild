# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/dejavu/dejavu-2.7.ebuild,v 1.7 2006/09/03 06:24:20 vapier Exp $

inherit font

MY_P="${PN}-ttf-${PV}"

DESCRIPTION="DejaVu fonts, bitstream vera with ISO-8859-2 characters"
HOMEPAGE="http://dejavu.sourceforge.net/"
LICENSE="BitstreamVera"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="alpha ~amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS BUGS LICENSE NEWS README status.txt langcover.txt unicover.txt"
FONT_SUFFIX="ttf"
S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
