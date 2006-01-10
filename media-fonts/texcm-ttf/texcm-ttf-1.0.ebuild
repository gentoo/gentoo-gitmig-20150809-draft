# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/texcm-ttf/texcm-ttf-1.0.ebuild,v 1.5 2006/01/10 18:45:03 hansmi Exp $

inherit font

DESCRIPTION="TeX's Computer Modern Fonts for MathML"
HOMEPAGE="http://www.mozilla.org/projects/mathml/fonts/"
SRC_URI="http://www.mozilla.org/projects/mathml/fonts/bakoma/${PN}.zip"

LICENSE="bakoma"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}"

FONT_SUFFIX="ttf"
