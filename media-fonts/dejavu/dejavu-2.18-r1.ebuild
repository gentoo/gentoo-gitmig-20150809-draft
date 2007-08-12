# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/dejavu/dejavu-2.18-r1.ebuild,v 1.5 2007/08/12 04:14:42 beandog Exp $

inherit font

MY_P="${PN}-ttf-${PV}"

DESCRIPTION="DejaVu fonts, bitstream vera with ISO-8859-2 characters"
HOMEPAGE="http://dejavu.sourceforge.net/"
LICENSE="BitstreamVera"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS BUGS NEWS README status.txt langcover.txt unicover.txt"
FONT_SUFFIX="ttf"
S="${WORKDIR}/${MY_P}"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks"

FONT_CONF="${FILESDIR}/59-dejavu.conf"
