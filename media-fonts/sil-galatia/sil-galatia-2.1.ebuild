# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-galatia/sil-galatia-2.1.ebuild,v 1.2 2011/06/14 10:59:03 pva Exp $

inherit font

MY_P=GalSIL21

DESCRIPTION="The Galatia SIL Greek Unicode Fonts package"
HOMEPAGE="http://scripts.sil.org/SILgrkuni"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS=( FONTLOG.txt )
FONT_SUFFIX="ttf"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
