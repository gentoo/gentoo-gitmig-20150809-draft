# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-galatia/sil-galatia-2.01.ebuild,v 1.1 2008/05/19 20:56:53 dirtyepic Exp $

inherit font

DESCRIPTION="The Galatia SIL Greek Unicode Fonts package"
HOMEPAGE="http://scripts.sil.org/SILgrkuni"
SRC_URI="mirror://gentoo/ttf-${P}.tgz"

LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DOCS="GalatiaTest.txt"
FONT_SUFFIX="ttf"

S="${WORKDIR}/ttf-${P}"
FONT_S="${S}"

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
