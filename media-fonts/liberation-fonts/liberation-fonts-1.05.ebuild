# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts/liberation-fonts-1.05.ebuild,v 1.3 2010/09/26 10:41:56 maekke Exp $

inherit font

DESCRIPTION="A GPL-2 Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://fedorahosted.org/liberation-fonts"
SRC_URI="!fontforge? ( http://github.com/downloads/kaio/${PN}/${PN}-ttf-${PV}.zip )
fontforge? ( http://github.com/downloads/kaio/${PN}/${P}.tar.gz )"

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2-with-exceptions"
IUSE="fontforge X"
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
DOCS="License.txt"

FONT_CONF=( "${FILESDIR}/60-liberation.conf" )

DEPEND="fontforge? ( media-gfx/fontforge )"
RDEPEND=""

if use fontforge; then
	FONT_S=${S}/ttf
else
	FONT_S=${WORKDIR}
fi
