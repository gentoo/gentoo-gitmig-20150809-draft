# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/texcm-ttf/texcm-ttf-1.0.ebuild,v 1.7 2006/09/03 06:45:44 vapier Exp $

inherit font

DESCRIPTION="TeX's Computer Modern Fonts for MathML"
HOMEPAGE="http://www.mozilla.org/projects/mathml/fonts/"
SRC_URI="http://www.mozilla.org/projects/mathml/fonts/bakoma/${PN}.zip"

LICENSE="bakoma"
SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ~ppc s390 sh sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}"

FONT_SUFFIX="ttf"
