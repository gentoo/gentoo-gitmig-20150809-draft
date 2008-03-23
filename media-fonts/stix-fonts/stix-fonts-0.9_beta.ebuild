# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/stix-fonts/stix-fonts-0.9_beta.ebuild,v 1.1 2008/03/23 19:25:11 dirtyepic Exp $

inherit font

DESCRIPTION="Comprehensive OpenType font set of mathematical symbols and alphabets"
HOMEPAGE="http://www.stixfonts.org/"
SRC_URI="mirror://gentoo/STIXBeta.zip"

LICENSE="stixbeta"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

FONT_SUFFIX="otf"
FONT_S="${WORKDIR}"
FONT_CONF=( "${FILESDIR}"/61-stix.conf )
DOCS="Readme.txt"

RESTRICT="strip binchecks"
